library design_package;

import 'package:design_package_template/design/design.dart';
import 'package:design_package_template/theme/dark_mode.dart';
import 'package:design_package_template/theme/light_mode.dart';
import 'package:flutter/material.dart';

export 'core/colors.dart';
export 'core/text_styles.dart';

class DesignPackageTheme {
  static final ThemeData light = lightTheme;
  static final ThemeData dark = darkTheme;
}

class DesignPackageThemeExtension {
  static final DesignTheme light = lightDesignThemeExtension;
  static final DesignTheme dark = darkDesignThemeExtension;
}
