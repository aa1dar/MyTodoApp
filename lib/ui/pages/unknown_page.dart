import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        title: Text(
          AppLocalizations.of(context)!.unknownRoute,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: const Center(child: Text('404')),
    );
  }
}
