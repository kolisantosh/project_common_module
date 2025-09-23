import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_common_module/core/utils/src/size_extension.dart';

import '../../core/constants/app_colors.dart';

class CommonHeaderTextField extends StatelessWidget {
  const CommonHeaderTextField({
    super.key,
    required this.headerText,
    required this.hintText,
    required this.validator,
    required this.controller,
    this.onChanged,
    this.autoValidationMode,
    this.inputFormatter,
    this.keyBoardType,
    this.onTap,
    this.suffix,
    this.focusNode,
    this.textInputAction,
    this.enabled,
    this.obscureText,
    this.maxLines,
  });

  final String headerText;
  final String hintText;
  final Widget? suffix;
  final bool? enabled;
  final bool? obscureText;
  final int? maxLines;
  final TextInputType? keyBoardType;
  final List<TextInputFormatter>? inputFormatter;
  final AutovalidateMode? autoValidationMode;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headerText.isNotEmpty) ...[
          Text(headerText, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 18.sp, color: AppColors.textColor)),
        ],
        SizedBox(height: 7.h),
        TextFormField(
          focusNode: focusNode,
          textInputAction: textInputAction,
          autovalidateMode: autoValidationMode ?? AutovalidateMode.onUserInteraction,
          keyboardType: keyBoardType,
          inputFormatters: inputFormatter,
          controller: controller,
          style: GoogleFonts.inter(fontSize: 17.sp, fontWeight: FontWeight.w600, color: AppColors.textColor),
          //textInputAction: TextInputAction.next,
          enabled: enabled,
          obscureText: obscureText ?? false,
          onChanged: onChanged,
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
            hintText: hintText,
            errorMaxLines: 2,
            hintStyle: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 35.sp, color: AppColors.textDisableColor),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.outLineColor),
              borderRadius: BorderRadius.circular(16.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(color: AppColors.outLineColor, width: 2.0.w),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
            suffixIcon: suffix,
          ),
          validator: validator,
          onTap: onTap,
          cursorColor: AppColors.textColor,
        ),
      ],
    );
  }
}
