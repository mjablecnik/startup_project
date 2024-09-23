import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as mt;
import 'package:flutter/painting.dart';
import 'package:design_package_template/core/text_styles.dart';
import 'package:design_package_template/core/colors.dart';
import 'package:design_package_template/design/design.dart';

get darkTheme {
  return mt.ThemeData(
    brightness: Brightness.dark,
    extensions: [darkDesignThemeExtension],
  );
}

final darkDesignThemeExtension = DesignTheme(
  buttonsStyle: ButtonsStyle(
    simpleButtonStyle: SimpleButtonStyle(
      defaultColor: DesignColors.purple,
      textStyle: TextStyles.mediumNormalText.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: DesignColors.whiteish,
      ),
    ),
  ),
);
