import 'package:flutter/material.dart';

import '/src/common/localization/app_localization.dart';

extension BuildContextX on BuildContext {
  /// Returns localized string from [AppLocalization].
  GeneratedLocalization stringOf() =>
      AppLocalization.stringOf<GeneratedLocalization>(this);

  /// Returns [ColorScheme] from [BuildContext]
  ColorScheme get colors => Theme.of(this).colorScheme;

  /// Returns [TextTheme] from [BuildContext].
  TextTheme get fonts => Theme.of(this).textTheme;
}
