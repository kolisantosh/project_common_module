import 'package:flutter/material.dart';
import 'package:project_common_module/views/widgets/pin_theme.dart';

import '../../core/constants/app_colors.dart';

/// PinCodeField
class PinCodeField extends StatelessWidget {
  const PinCodeField({Key? key, required this.pin, required this.pinCodeFieldIndex, required this.theme}) : super(key: key);

  /// The pin code
  final String pin;

  /// The the index of the pin code field
  final PinTheme theme;

  /// The index of the pin code field
  final int pinCodeFieldIndex;

  Color get getFillColorFromIndex {
    if (pin.length > pinCodeFieldIndex) {
      return AppColors.primaryColor;
    } else if (pin.length == pinCodeFieldIndex) {
      return AppColors.white;
    }
    return AppColors.white;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 20,
      width: 20,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: getFillColorFromIndex,
        // borderRadius: BorderRadius.zero,
        shape: BoxShape.circle,
        // border: Border.all(
        //   color: getFillColorFromIndex,
        //   width: 2,
        // ),
      ),
      duration: const Duration(microseconds: 40000),
      child: pin.length > pinCodeFieldIndex ? Icon(Icons.circle, color: getFillColorFromIndex, size: 12) : const SizedBox(),
    );
  }
}
