import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FilterType { none, uncompleted }

final filterStateProvider = StateProvider<FilterType>((ref) {
  return FilterType.none;
});
