// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_element, unnecessary_cast

part of 'simple_button.style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$SimpleButtonStyleTailorMixin on ThemeExtension<SimpleButtonStyle> {
  Color get defaultColor;
  TextStyle get textStyle;

  @override
  SimpleButtonStyle copyWith({
    Color? defaultColor,
    TextStyle? textStyle,
  }) {
    return SimpleButtonStyle(
      defaultColor: defaultColor ?? this.defaultColor,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  SimpleButtonStyle lerp(
      covariant ThemeExtension<SimpleButtonStyle>? other, double t) {
    if (other is! SimpleButtonStyle) return this as SimpleButtonStyle;
    return SimpleButtonStyle(
      defaultColor: Color.lerp(defaultColor, other.defaultColor, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SimpleButtonStyle &&
            const DeepCollectionEquality()
                .equals(defaultColor, other.defaultColor) &&
            const DeepCollectionEquality().equals(textStyle, other.textStyle));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(defaultColor),
      const DeepCollectionEquality().hash(textStyle),
    );
  }
}
