import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:todo_app/my_app.dart';
import 'package:todo_app/navigation/app_navigation.dart';
import 'package:todo_app/providers/count_of_task_provider.dart';
import 'package:todo_app/providers/filtered_task_list_provider.dart';
import 'package:todo_app/providers/loading_state_provider.dart';
import 'package:todo_app/providers/task_filter_provider.dart';
import 'package:todo_app/providers/task_list_provider.dart';
import 'package:todo_app/ui/widgets/banner_wrapper.dart';
import 'package:todo_app/ui/widgets/custom_floating_action_button.dart';
import 'package:todo_app/ui/widgets/task_item.dart';
import 'package:todo_app/utils/style/app_themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/custom_header_delegate.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  // final void Function() onTapCreateNewTask;
  // final void Function(String itemId) onTaskTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    final countOfTask = ref.watch(countOfTaskProvider);

    final filter = ref.watch(filterStateProvider);

    final isLoading = ref.watch(isLoadingTasksProvider);

    final countOfTaskString = isLoading ? '...' : countOfTask;

    IconData? getIcon() {
      return filter == FilterType.none
          ? Icons.visibility_off
          : Icons.visibility;
    }

    return BannerWrapper(
        child: Scaffold(
            floatingActionButton: CustomFab(
                onTap: !isLoading
                    ? () => ref.read(navigationProvider).showTaskCreationPage()
                    : null),
            body: CustomScrollView(slivers: [
              SliverPersistentHeader(
                delegate: CustomHeaderDelegate(
                    action: IconButton(
                      splashRadius: AppTheme.appBarIconSplashRadius,
                      icon: Icon(getIcon(),
                          color: Theme.of(context).colorScheme.primary),
                      onPressed: isLoading
                          ? null
                          : () {
                              final currentState =
                                  ref.read(filterStateProvider);
                              FilterType newState =
                                  currentState == FilterType.none
                                      ? FilterType.uncompleted
                                      : FilterType.none;
                              ref.read(filterStateProvider.notifier).state =
                                  newState;
                            },
                    ),
                    expandedTitle: Text(
                      AppLocalizations.of(context)!.myTasks,
                      style: textStyle.titleLarge,
                    ),
                    collapsedSubTitle: Text(
                        '${AppLocalizations.of(context)!.completed} — $countOfTaskString',
                        style:
                            Theme.of(context).inputDecorationTheme.hintStyle),
                    collapsedTitle: Text(
                      AppLocalizations.of(context)!.myTasks,
                      style: textStyle.titleMedium,
                    ),
                    expandedHeight: 160.0,
                    statusBarHeight: MediaQuery.of(context).padding.top,
                    backgroundColor:
                        Theme.of(context).appBarTheme.surfaceTintColor!),
                pinned: true,
              ),
              isLoading
                  ? SliverToBoxAdapter(
                      child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: const CircularProgressIndicator(),
                    ))
                  : SliverStack(
                      children: [
                        SliverPositioned.fill(
                          child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: horizontalPadding, vertical: 4.0),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      spreadRadius: 2,
                                      blurRadius: 0.5,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0)))),
                        ),
                        SliverPadding(
                            padding: const EdgeInsets.only(
                                right: horizontalPadding,
                                left: horizontalPadding,
                                top: 4.0,
                                bottom: 52.0),
                            sliver: SliverList.builder(
                                itemCount: ref.watch(
                                    filteredTaskListProvider.select(
                                        (taskList) => taskList.data.length)),
                                itemBuilder: (context, index) {
                                  return ProviderScope(
                                    overrides: [
                                      taskProvider.overrideWithValue(ref
                                          .watch(filteredTaskListProvider)
                                          .data[index])
                                    ],
                                    child: TaskItem(
                                        onTaskTap: (taskId) => ref
                                            .read<AppNavigation>(
                                                navigationProvider)
                                            .showTaskEditingPage(taskId)),
                                  );
                                })),
                        SliverPositioned(
                            bottom: 0,
                            left: horizontalPadding,
                            right: horizontalPadding,
                            child: InkWell(
                                onTap: () => ref
                                    .read<AppNavigation>(navigationProvider)
                                    .showTaskCreationPage(),
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18.0, horizontal: 8.0 + 40),
                                    child: Text(
                                      AppLocalizations.of(context)!.addNew,
                                      style: Theme.of(context)
                                          .inputDecorationTheme
                                          .hintStyle,
                                    ))))
                      ],
                    ),
            ])));
  }

  static const horizontalPadding = 8.0;
}
