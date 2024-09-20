import 'package:flutter/material.dart';
import 'package:design_package_template/core/colors.dart';

///
/// Here will be the most common text styles.
/// For customization can be used copyWith.
///
/// For example:
/// TextStyle customStyle = TextStyles.largeBoldText.copyWith(
///   color: Colors.red,
///   decoration: TextDecoration.underline,
/// );
///
class TextStyles {
  static const TextStyle extraLargeBoldText = TextStyle(
    fontSize: 24,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    color: DesignColors.black,
  );

  static const TextStyle extraLargeNormalText = TextStyle(
    fontSize: 24,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    color: DesignColors.black,
  );

  static const TextStyle extraLargeLightText = TextStyle(
    fontSize: 24,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w100,
    color: DesignColors.black,
  );

  static const TextStyle largeBoldText = TextStyle(
    fontSize: 20,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    color: DesignColors.black,
  );

  static const TextStyle largeNormalText = TextStyle(
    fontSize: 20,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    color: DesignColors.black,
  );

  static const TextStyle largeLightText = TextStyle(
    fontSize: 20,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w100,
    color: DesignColors.black,
  );

  static const TextStyle mediumBoldText = TextStyle(
    fontSize: 16,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    color: DesignColors.black,
  );

  static const TextStyle mediumNormalText = TextStyle(
    fontSize: 16,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    color: DesignColors.black,
  );

  static const TextStyle mediumLightText = TextStyle(
    fontSize: 16,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w100,
    color: DesignColors.black,
  );

  static const TextStyle smallBoldText = TextStyle(
    fontSize: 12,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    color: DesignColors.black,
  );

  static const TextStyle smallNormalText = TextStyle(
    fontSize: 12,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    color: DesignColors.black,
  );

  static const TextStyle smallLightText = TextStyle(
    fontSize: 12,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w100,
    color: DesignColors.black,
  );

  static const TextStyle tinyBoldText = TextStyle(
    fontSize: 8,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    color: DesignColors.black,
  );

  static const TextStyle tinyNormalText = TextStyle(
    fontSize: 8,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    color: DesignColors.black,
  );

  static const TextStyle tinyLightText = TextStyle(
    fontSize: 8,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w100,
    color: DesignColors.black,
  );
}

extension TextStyleCopyWith on TextStyle {
  TextStyle copyWith({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) {
    return TextStyle(
      color: color ?? this.color,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      textBaseline: textBaseline ?? this.textBaseline,
      height: height ?? this.height,
      locale: locale ?? this.locale,
      foreground: foreground ?? this.foreground,
      background: background ?? this.background,
      shadows: shadows ?? this.shadows,
      fontFeatures: fontFeatures ?? this.fontFeatures,
      decoration: decoration ?? this.decoration,
      decorationColor: decorationColor ?? this.decorationColor,
      decorationStyle: decorationStyle ?? this.decorationStyle,
      decorationThickness: decorationThickness ?? this.decorationThickness,
    );
  }
}
