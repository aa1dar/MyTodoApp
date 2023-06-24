import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum TaskPriority { low, normal, high }

extension ConverToString on TaskPriority {
  String toReadableString(BuildContext context) {
    switch (this) {
      case TaskPriority.high:
        return '!! ${AppLocalizations.of(context)!.high}';
      case TaskPriority.low:
        return AppLocalizations.of(context)!.low;
      case TaskPriority.normal:
        return AppLocalizations.of(context)!.basic;
    }
  }
}
