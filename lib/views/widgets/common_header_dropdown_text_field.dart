import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_common_module/core/utils/src/size_extension.dart';

import '../../core/constants/app_colors.dart';

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

class CommonHeaderMultiSelectDropDown<T> extends FormField<List<T>> {
  CommonHeaderMultiSelectDropDown({
    super.key,
    required this.headerText,
    required this.hintText,
    required this.items,
    required this.itemLabels,
    required this.onChanged,
    this.autoValidationMode,
    this.suffix,
    this.focusNode,
    super.initialValue,
    super.validator,
  }) : super(
         builder: (FormFieldState<List<T>> field) {
           final selected = field.value ?? [];
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               if (headerText.isNotEmpty)
                 Text(headerText, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 35.sp, color: AppColors.textColor)),
               SizedBox(height: 16.h),
               DropDownTextField.multiSelection(
                 // controller: _cntMulti,
                 // initialValue: const ["name1", "name2", "name8", "name3"],
                 // displayCompleteItem: true,
                 submitButtonColor: AppColors.primaryColor,
                 textFieldDecoration: InputDecoration(
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(15.r),
                     borderSide: BorderSide(color: AppColors.primaryColor, width: 2.w),
                   ),
                 ),

                 submitButtonText: 'save',
                 checkBoxProperty: CheckBoxProperty(
                   fillColor: MaterialStateProperty.all<Color>(AppColors.hyperLinkColor),
                   activeColor: AppColors.white,
                   checkColor: AppColors.white,
                   side: BorderSide(color: AppColors.primaryColor, width: 2.w),
                 ),
                 dropDownList: const [
                   DropDownValueModel(name: 'Phone', value: "value1"),
                   DropDownValueModel(
                     name: 'Laptop',
                     value: "value2",
                     // toolTipMsg: "DropDownButton is a widget that we can use to select one unique value from a set of values",
                   ),
                   DropDownValueModel(name: 'PC', value: "value3"),
                   DropDownValueModel(
                     name: 'TV',
                     value: "value4",
                     // toolTipMsg: "DropDownButton is a widget that we can use to select one unique value from a set of values",
                   ),
                   DropDownValueModel(name: 'Mobile', value: "value5"),
                 ],
                 onChanged: (val) {},
               ),
             ],
           );
         },
       );

  final String headerText;
  final String hintText;
  final List<T> items;
  final Map<T, String> itemLabels;
  final ValueChanged<List<T>> onChanged;
  final AutovalidateMode? autoValidationMode;
  final Widget? suffix;
  final FocusNode? focusNode;
}
