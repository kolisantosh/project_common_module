import 'package:flutter/material.dart';

Map<int, Color> textColorSwatch = {
  50: const Color(0x80cdf6f7),
  100: const Color(0xFFCDF6F7),
  200: const Color(0xFF9BEDEF),
  300: const Color(0xff6ae5e8),
  400: const Color(0xFF38DCE0),
  500: const Color(0xFF06D3D8),
  600: const Color(0xFF05A9AD),
  700: const Color(0xff047f82),
  800: const Color(0xff025456),
  900: const Color(0xff012a2b),
};

/// Enter your app primer color code ----->>
class AppColors {
  static Color primaryColor = Color(0xFF003366);
  static MaterialColor primerColor = MaterialColor(0xFF10203C, textColorSwatch);

  static Color primaryDullColor = Color(0xFF99B4C7);
  static Color primaryDullColor1 = Color(0xFFE9F6FD);
  static Color backgroundColor = Color(0xFF003366);
  static Color backgroundColor1 = Color(0xFFE5EBF0);

  static const Color outLineColor = Color(0xFFE9EBED);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const Color successColor = Color(0xFF4CD02B);
  static const Color successDullColor = Color(0x334CD02B);

  static const Color alertColor = Color(0xFFD82929);
  static const Color alertColor1 = Color(0xFFC93E3E);
  static const Color alertDullColor = Color(0xFFFFC2C2);

  static const Color diffColor = Color(0xFFA267FA);
  static const Color diffDullColor = Color(0x1FA267FA);

  static const Color blueColor = Color(0xFF2E3DE5);
  static const Color pendingColor = Color(0xFFDFAA41);
  static const Color pendingDullColor = Color(0x33DFAA41);

  static const Color hyperLinkColor = Color(0xFF27A1ED);
  static const Color headerTextColor = Color(0xFF141B2A);
  static const Color textColor = Color(0xFF404244);
  static const Color textDisableColor = Color(0xFFAEAEAE);
}
