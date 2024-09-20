import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'simple_button.style.tailor.dart';

@tailorMixinComponent
class SimpleButtonStyle extends ThemeExtension<SimpleButtonStyle> with _$SimpleButtonStyleTailorMixin {
  const SimpleButtonStyle({
    required this.defaultColor,
    required this.textStyle,
  });

  @override
  final Color defaultColor;

  @override
  final TextStyle textStyle;
}
