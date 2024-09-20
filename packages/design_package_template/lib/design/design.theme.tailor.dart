// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_element, unnecessary_cast

part of 'design.theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$DesignThemeTailorMixin on ThemeExtension<DesignTheme> {
  ButtonsStyle get buttonsStyle;

  @override
  DesignTheme copyWith({
    ButtonsStyle? buttonsStyle,
  }) {
    return DesignTheme(
      buttonsStyle: buttonsStyle ?? this.buttonsStyle,
    );
  }

  @override
  DesignTheme lerp(covariant ThemeExtension<DesignTheme>? other, double t) {
    if (other is! DesignTheme) return this as DesignTheme;
    return DesignTheme(
      buttonsStyle: buttonsStyle.lerp(other.buttonsStyle, t) as ButtonsStyle,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DesignTheme &&
            const DeepCollectionEquality()
                .equals(buttonsStyle, other.buttonsStyle));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(buttonsStyle),
    );
  }
}

extension DesignThemeBuildContextProps on BuildContext {
  DesignTheme get designTheme => Theme.of(this).extension<DesignTheme>()!;
  ButtonsStyle get buttonsStyle => designTheme.buttonsStyle;
}
