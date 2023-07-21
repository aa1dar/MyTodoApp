class NavigationState {
  final bool? _unknown;
  final bool? _taskCreation;

  String? selectedTaskId;

  bool get isTaskDetailPage => selectedTaskId != null;

  bool get isTaskCreationPage => _taskCreation == true;

  bool get isRoot => !isTaskDetailPage && !isTaskCreationPage && !isUnknown;

  bool get isUnknown => _unknown == true;

  NavigationState.root()
      : _taskCreation = false,
        _unknown = false,
        selectedTaskId = null;

  NavigationState.taskCreation()
      : _taskCreation = true,
        _unknown = false,
        selectedTaskId = null;

  NavigationState.taskEditing(this.selectedTaskId)
      : _taskCreation = false,
        _unknown = false;

  NavigationState.unknown()
      : _unknown = true,
        _taskCreation = false,
        selectedTaskId = null;
}
