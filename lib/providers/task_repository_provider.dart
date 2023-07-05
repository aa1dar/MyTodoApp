import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/storage/local/revision_local_repository.dart';
import 'package:todo_app/storage/local/task_list_local_repository.dart';
import 'package:todo_app/storage/main_repository.dart';
import 'package:todo_app/storage/network/api_service.dart';
import 'package:todo_app/storage/network/task_list_network_repository.dart';

final taskRepositoryProvider = Provider<MainRepository>((ref) {
  final repository = MainRepository(TaskListLocalRepository(),
      TaskListNetworkRepository(ApiService()), RevisionLocalRepository());
  ref.onDispose(() {
    ref.state.dispose();
  });
  return repository;
});
