export 'simple_button/simple_button.dart';

import 'package:design_package_template/design/buttons/simple_button/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'buttons.tailor.dart';

@TailorMixin()
class ButtonsStyle extends ThemeExtension<ButtonsStyle> with _$ButtonsStyleTailorMixin {
  const ButtonsStyle({
    required this.simpleButtonStyle,
  });

  @override
  @themeExtension
  final SimpleButtonStyle simpleButtonStyle;
}
