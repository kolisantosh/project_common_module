import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_common_module/core/utils/src/size_extension.dart';

import '../../core/constants/app_colors.dart';

/*class CommonHeaderDropDownTextField extends StatelessWidget {
  const CommonHeaderDropDownTextField({
    super.key,
    required this.headerText,
    required this.hintText,
    this.validator,
    required this.onChanged,
    required this.items,
    this.autoValidationMode,
    this.onTap,
    this.suffix,
    this.focusNode,
    this.bgColor,
  });

  final String headerText;
  final String hintText;
  final Widget? suffix;
  final List<DropdownMenuItem<String>> items;
  final AutovalidateMode? autoValidationMode;
  final ValueChanged<String> onChanged;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headerText.isNotEmpty) ...[
          Text(headerText, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 18.sp, color: AppColors.textColor)),
          SizedBox(height: 7.h),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(12.w),
          child: Container(
            color: bgColor,
            child: DropdownButtonFormField<String>(
              items: items,
              validator: validator,
              autovalidateMode: autoValidationMode,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15.sp, color: AppColors.textDisableColor),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.w)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.w),
                  borderSide: BorderSide(color: bgColor ?? AppColors.outLineColor, width: 2.0.w),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0.w),
                  borderSide: BorderSide(color: bgColor ?? AppColors.outLineColor, width: 2.0.w),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
              ),
              icon: suffix,
              onChanged: (value) {
                onChanged(value!);
              },
            ),
          ),
        ),
      ],
    );
  }
}*/

class CommonHeaderDropDownTextField<T> extends FormField<T> {
  CommonHeaderDropDownTextField({
    super.key,
    required this.headerText,
    required this.hintText,
    required this.onChanged,
    required this.items,
    this.autoValidationMode,
    this.onTap,
    this.suffix,
    this.focusNode,
    super.initialValue, // Allows setting default selected value
    super.validator,
  }) : super(
         builder: (FormFieldState<T> field) {
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               if (headerText.isNotEmpty) ...[
                 Text(headerText, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 35.sp, color: AppColors.textColor)),
               ],
               SizedBox(height: 16.h),
               DropdownButtonFormField<T>(
                 value: initialValue, // Keeps the selected value
                 items: items,
                 validator: validator,
                 autovalidateMode: autoValidationMode,
                 // selectedItemBuilder: (context) {
                 //   return items.map((item) {
                 //     final isSelected = item.value == initialValue;
                 //     return Align(
                 //       alignment: Alignment.centerLeft,
                 //       child: Text(
                 //         item.child is Text ? (item.child as Text).data ?? '' : '',
                 //         style: GoogleFonts.inter(
                 //           fontWeight: FontWeight.w700,
                 //           fontSize: 35.sp,
                 //           color: isSelected ? AppColors.primaryColor : AppColors.textColor,
                 //         ),
                 //       ),
                 //     );
                 //   });
                 // },
                 decoration: InputDecoration(
                   hintText: hintText,
                   hintStyle: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 35.sp, color: AppColors.textDisableColor),
                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.r)),
                   focusedBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(25.r),
                     borderSide: BorderSide(color: AppColors.outLineColor, width: 2.0.w),
                   ),
                   enabledBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(25.r),
                     borderSide: BorderSide(color: AppColors.outLineColor, width: 2.0.w),
                   ),
                   contentPadding: EdgeInsets.symmetric(vertical: 39.h, horizontal: 20.w),
                 ),
                 icon: suffix,
                 focusNode: focusNode,
                 onTap: onTap,
                 onChanged: (value) {
                   field.didChange(value);
                   if (value != null) onChanged(value);
                 },
               ),
             ],
           );
         },
       );

  final String headerText;
  final String hintText;
  final Widget? suffix;
  final List<DropdownMenuItem<T>> items;
  final AutovalidateMode? autoValidationMode;
  final ValueChanged<T> onChanged;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
}
