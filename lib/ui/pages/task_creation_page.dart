import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/my_app.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/models/task_priority.dart';
import 'package:todo_app/navigation/app_navigation.dart';
import 'package:todo_app/providers/change_task_provider.dart';
import 'package:todo_app/providers/task_list_provider.dart';
import 'package:todo_app/ui/pages/unknown_page.dart';
import 'package:todo_app/utils/style/app_themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskCreationPage extends ConsumerStatefulWidget {
  const TaskCreationPage({
    this.taskId,
    super.key,
  });
  final String? taskId;

  @override
  ConsumerState<TaskCreationPage> createState() => _TaskCreationPageState();
}

class _TaskCreationPageState extends ConsumerState<TaskCreationPage> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  final List<TaskPriority> _list = TaskPriority.values.toList();
  String? _editingTaskId;

  TaskPriority? _dropdownValue = TaskPriority.normal;
  DateTime? _selectedDate;
  bool _switcher = false;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    _loadData();
    super.initState();
  }

  bool get _isEditing => _editingTaskId != null;

  void _loadData() async {
    if (widget.taskId == null) {
      _editingTaskId = null;
      return;
    }
    _initializeTaskPamaters(
        ref.read(changeTaskListProvider(widget.taskId)).task);
  }

  void _subsribeOnDataLoading() {
    ref.listen(changeTaskListProvider(widget.taskId), (prev, next) {
      // TODO: Get rid of this workaround and put all logic of this page
      // to the StateNotifierProvider
      if (prev?.isLoading == true && !next.isLoading) {
        if (!next.isUndefinedIndex) {
          _initializeTaskPamaters(next.task);
        }
      }
    });
  }

  void _initializeTaskPamaters(TaskModel task) {
    _editingTaskId = widget.taskId;
    _textEditingController.text = task.description;
    _selectedDate = task.deadline;
    _dropdownValue = task.priority;
    _switcher = task.deadline != null;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).languageCode;
    final isUndefined =
        ref.watch(changeTaskListProvider(widget.taskId)).isUndefinedIndex;
    final isLoading =
        ref.watch(changeTaskListProvider(widget.taskId)).isLoading;
    _subsribeOnDataLoading();

    if (isUndefined) {
      return const UnknownPage();
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            splashRadius: AppTheme.appBarIconSplashRadius,
            onPressed: () =>
                ref.read<AppNavigation>(navigationProvider).returnToRootPage(),
          ),
          actions: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: TextButton(
                  onPressed: onSave,
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 4.0)),
                  child: Text(AppLocalizations.of(context)!.save),
                ))
          ],
        ),
        body: Builder(
          builder: (context) {
            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Flexible(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 4.0),
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        child: TextField(
                          style: textStyle.bodyMedium,
                          onTapOutside: (event) => _focusNode.unfocus(),
                          minLines: 3,
                          maxLines: null,
                          autofocus: false,
                          focusNode: _focusNode,
                          scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.whatNeeds,
                          ),
                          controller: _textEditingController,
                        )),
                  ),
                  const SizedBox(height: 28.0),
                  Flexible(
                    child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppLocalizations.of(context)!.importance,
                                  style: textStyle.bodyMedium),
                              const SizedBox(height: 4.0),
                              Theme(
                                data: Theme.of(context).copyWith(
                                    highlightColor: Colors.transparent),
                                child: PopupMenuButton(
                                  surfaceTintColor: Colors.transparent,
                                  position: PopupMenuPosition.over,
                                  tooltip: AppLocalizations.of(context)!
                                      .selectThePriority,
                                  initialValue: _dropdownValue,
                                  itemBuilder: (context) {
                                    return _list
                                        .map<PopupMenuItem<TaskPriority>>(
                                            (TaskPriority value) {
                                      Color? textColor =
                                          value == TaskPriority.high
                                              ? colorScheme.error
                                              : null;
                                      return PopupMenuItem<TaskPriority>(
                                          value: value,
                                          child: Text(
                                            value.toReadableString(context),
                                            style: textStyle.bodyMedium!
                                                .copyWith(color: textColor),
                                          ));
                                    }).toList();
                                  },
                                  onSelected: (TaskPriority value) {
                                    setState(() {
                                      _dropdownValue = value;
                                    });
                                  },
                                  child: Builder(
                                    builder: (context) {
                                      Color? textColor =
                                          _dropdownValue == TaskPriority.normal
                                              ? colorScheme.tertiary
                                              : null;

                                      return Text(
                                        _dropdownValue!
                                            .toReadableString(context),
                                        style: textStyle.titleSmall!
                                            .copyWith(color: textColor),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              const Divider(),
                              const SizedBox(height: 16.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.deadline,
                                        style: textStyle.bodyMedium,
                                      ),
                                      if (_selectedDate != null)
                                        InkWell(
                                            onTap: () => _showDatePicker(),
                                            child: Text(
                                                DateFormat.yMMMMd(locale)
                                                    .format(_selectedDate!),
                                                style: textStyle.labelLarge!
                                                    .copyWith(
                                                        color: colorScheme
                                                            .primary)))
                                    ],
                                  ),
                                  Switch(
                                      value: _switcher,
                                      onChanged: (change) {
                                        setState(() {
                                          _switcher = change;
                                          if (change) {
                                            _selectedDate = DateTime.now();
                                          } else {
                                            _selectedDate = null;
                                          }
                                        });
                                      })
                                ],
                              )
                            ])),
                  ),
                  const Divider(),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextButton.icon(
                          onPressed: _isEditing ? onDelete : null,
                          style: TextButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              foregroundColor: colorScheme.error,
                              textStyle: textStyle.bodyMedium,
                              disabledForegroundColor: colorScheme.surface),
                          icon: const Icon(Icons.delete),
                          label: Text(AppLocalizations.of(context)!.delete))),
                ]));
          },
        ));
  }

  void onDelete() {
    ref.read(taskListProvider.notifier).delete(_editingTaskId!);
    ref.read(navigationProvider).onPop();
  }

  void onSave() {
    if (!validateText(_textEditingController.text)) {
      return;
    }
    if (_isEditing) {
      final newTask = TaskModel(
          id: _editingTaskId!,
          description: _textEditingController.text,
          deadline: _selectedDate,
          priority: _dropdownValue ?? TaskPriority.normal);
      ref.read(taskListProvider.notifier).change(_editingTaskId!, newTask);
    } else {
      ref.read(taskListProvider.notifier).add(_textEditingController.text,
          priority: _dropdownValue ?? TaskPriority.normal,
          deadline: _selectedDate);
    }

    ref.read(navigationProvider).onPop();
  }

  void _showDatePicker() async {
    final newDate = await showDatePicker(
      helpText: '',
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      confirmText: AppLocalizations.of(context)!.done,
      cancelText: AppLocalizations.of(context)!.cancel,
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      builder: (context, child) => Container(
        child: child,
      ),
      lastDate: DateTime(2100),
    );

    if (newDate != null) {
      setState(() {
        _selectedDate = newDate;
      });
    }
  }

  bool validateText(String text) {
    if (text.isNotEmpty) {
      return true;
    }

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).cardColor,
              title: Text(
                AppLocalizations.of(context)!.emptyDescription,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              content: Text(
                AppLocalizations.of(context)!.enterTheTaskDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(AppLocalizations.of(context)!.ok))
              ],
            ));

    return false;
  }
}
