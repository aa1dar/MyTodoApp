enum TaskPriority { normal, low, high }

extension ConverToString on TaskPriority {
  String toReadableString() {
    switch (this) {
      case TaskPriority.high:
        return '!! Высокий';
      case TaskPriority.low:
        return 'Низкий';
      case TaskPriority.normal:
        return 'Нет';
    }
  }
}
