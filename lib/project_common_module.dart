library patient_app_common;

import 'dart:ui';

import 'core/constants/app_colors.dart';

class Initializer {
  static void initAppColors({
    required Color primaryColor,
    Color? appBgColor1,
    Color? appBgColor2,
    Color? appBgColor3,
    Color? textColor1,
    Color? grayColor,
    Color? inactiveBgColor,
    Color? inactiveTextColor,
    Color? activeTextColor,
    Color? activeBorderColor,
    Color? orangeColor,
    Color? redColor,
    Color? greyColor,
  }) {
    AppColors.primaryColor = primaryColor;
    // if (appBgColor1 != null) AppColors.appBgColor1 = appBgColor1;
    // if (appBgColor2 != null) AppColors.appBgColor2 = appBgColor2;
    // if (appBgColor3 != null) AppColors.appBgColor3 = appBgColor3;
    // if (textColor1 != null) AppColors.textColor1 = textColor1;
    // if (grayColor != null) AppColors.grayColor = grayColor;
    // if (inactiveBgColor != null) AppColors.inactiveBgColor = inactiveBgColor;
    // if (inactiveTextColor != null) AppColors.inactiveTextColor = inactiveTextColor;
    // if (activeTextColor != null) AppColors.activeTextColor = activeTextColor;
    // if (activeBorderColor != null) AppColors.activeBorderColor = activeBorderColor;
    // if (orangeColor != null) AppColors.orangeColor = orangeColor;
    // if (redColor != null) AppColors.redColor = redColor;
    // if (greyColor != null) AppColors.greyColor = greyColor;
  }

  static void initAppConfig() {}
}
