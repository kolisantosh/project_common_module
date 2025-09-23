import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_common_module/core/utils/src/size_extension.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/strings.dart';

class MobileNumberInput extends StatelessWidget {
  const MobileNumberInput({
    super.key,
    this.onChanged,
    required this.validator,
    required this.controller,
    this.suffix,
    this.changePassword = false,
  });
  final Widget? suffix;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final bool changePassword;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          changePassword ? Strings.mobileNumber : Strings.mobileNumber,
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 18.sp, color: AppColors.textColor),
        ),
        SizedBox(height: 7.h),
        TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: GoogleFonts.inter(fontSize: 17.sp, fontWeight: FontWeight.w600, color: AppColors.textColor),
          keyboardType: TextInputType.number,
          //textInputAction: TextInputAction.next,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: changePassword ? Strings.enterNewMobileNumber : Strings.enterMobileNumber,
            hintStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 17.sp, color: AppColors.textDisableColor),
            prefixIcon: Padding(
              padding: EdgeInsets.all(15.0.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("+91  ", style: GoogleFonts.inter(fontSize: 17.sp, fontWeight: FontWeight.w600)),
                  Text(" |", style: GoogleFonts.inter(fontSize: 17.sp, fontWeight: FontWeight.w600, color: AppColors.textDisableColor)),
                ],
              ),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.w)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.outLineColor),
              borderRadius: BorderRadius.circular(12.w),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0.w),
              borderSide: BorderSide(color: AppColors.outLineColor, width: 2.0.w),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
            suffixIcon: suffix,
          ),
          validator: validator,
          cursorColor: AppColors.textColor,
        ),
      ],
    );
  }
}
