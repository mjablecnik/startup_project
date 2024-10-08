import 'package:design_package_template/design_package_example.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as mt;
import 'package:flutter/painting.dart';
import 'package:flutter_project_template/core/theme/app.dart';
import 'package:flutter_project_template/core/theme/modes/colors.dart';
import 'package:flutter_project_template/core/theme/components.dart';
import 'package:flutter_project_template/core/theme/pages.dart';

get darkTheme {
  return mt.ThemeData(
    brightness: Brightness.dark,
    extensions:  [
      DesignPackageThemeExtension.dark,
      const AppTheme(
        layout: LayoutTheme(
          backgroundColor: AppColors.greyDark,
          appBarColor: AppColors.green,
          appBarText: TextStyle(color: AppColors.whiteish),
        ),
        errorPage: ErrorPageTheme(
          titleText: TextStyle(
            fontSize: 30,
            fontWeight: mt.FontWeight.w600,
          ),
          descriptionText: TextStyle(fontSize: 20),
          detailText: TextStyle(fontSize: 15, fontWeight: mt.FontWeight.w400),
          detailTextButtonIcon: AppColors.green,
          detailTextButton: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColors.green,
            decorationColor: AppColors.green,
            decoration: TextDecoration.underline,
          ),
        ),
        loginPage: LoginPageTheme(
          titleText: TextStyle(),
          button: ButtonComponentTheme(
            backgroundColor: AppColors.black,
            textColor: AppColors.whiteish,
            textStyle: TextStyle(),
          ),
        ),
      )
    ],
  );
}
