export 'buttons/buttons.dart';

import 'package:design_package_template/design/buttons/buttons.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'design.tailor.dart';

@TailorMixin()
class DesignTheme extends ThemeExtension<DesignTheme> with _$DesignThemeTailorMixin {
  const DesignTheme({
    required this.buttonsStyle,
  });

  @override
  @themeExtension
  final ButtonsStyle buttonsStyle;
}