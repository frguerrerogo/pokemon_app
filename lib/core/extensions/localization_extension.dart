import 'package:flutter/material.dart';
import 'package:pokemon_app/l10n/app_localizations.dart';

/// Extension for easy access to localized strings via [BuildContext].
extension LocalizationExtension on BuildContext {
  /// Returns the current [AppLocalizations] instance from the context.
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
