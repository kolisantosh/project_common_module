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
               GestureDetector(
                 onTap: () async {
                   final result = await showDialog<List<T>>(
                     context: field.context,
                     builder: (ctx) {
                       final tempSelected = List<T>.from(selected);
                       return AlertDialog(
                         title: Text(headerText),
                         content: SingleChildScrollView(
                           child: Column(
                             children:
                                 items.map((item) {
                                   final label = itemLabels[item] ?? item.toString();
                                   return CheckboxListTile(
                                     value: tempSelected.contains(item),
                                     title: Text(label),
                                     onChanged: (checked) {
                                       if (checked == true) {
                                         tempSelected.add(item);
                                       } else {
                                         tempSelected.remove(item);
                                       }
                                       (ctx as Element).markNeedsBuild();
                                     },
                                   );
                                 }).toList(),
                           ),
                         ),
                         actions: [
                           TextButton(onPressed: () => Navigator.pop(ctx, selected), child: const Text('Cancel')),
                           TextButton(onPressed: () => Navigator.pop(ctx, tempSelected), child: const Text('OK')),
                         ],
                       );
                     },
                   );
                   if (result != null) {
                     field.didChange(result);
                     onChanged(result);
                   }
                 },
                 child: AbsorbPointer(
                   child: TextFormField(
                     controller: TextEditingController(
                       text: selected.isEmpty ? '' : selected.map((e) => itemLabels[e] ?? e.toString()).join(', '),
                     ),
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
                       suffixIcon: suffix,
                     ),
                     focusNode: focusNode,
                     readOnly: true,
                     // validator: validator,
                     autovalidateMode: autoValidationMode,
                   ),
                 ),
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

class PrimaryDropDownField extends StatefulWidget {
  final IconData? icon;
  final String labelText;
  final Color? labelColor;
  final Color? borderColor;
  final Color? errorColor;
  final Color? backgroundColor;
  final Color? textColor;
  final String? hintText;
  final String? preFilled;
  final bool? isRequired;
  final String valueKey;
  final EdgeInsetsGeometry? margin;
  final Widget? suffix;
  final Widget? prefix;
  final List<dynamic> items;
  final ValueChanged<dynamic> onChanged;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final GlobalKey<FormFieldState>? dropDownKey;
  final double? width;
  final bool? isSearchable;
  final bool? readOnly;
  final double? radius;
  final double? textSize;
  final double? labelSize;
  final EdgeInsetsGeometry? padding;
  final FocusNode? focusNode;

  const PrimaryDropDownField({
    Key? key,
    this.icon,
    required this.labelText,
    this.hintText,
    this.labelColor,
    this.suffix,
    this.prefix,
    required this.onChanged,
    this.onTap,
    this.validator,
    this.textColor,
    required this.valueKey,
    required this.items,
    this.margin,
    this.dropDownKey,
    this.width,
    this.isRequired,
    this.preFilled,
    this.isSearchable,
    this.radius,
    this.textSize,
    this.labelSize,
    this.backgroundColor,
    this.readOnly,
    this.padding,
    this.borderColor,
    this.errorColor,
    this.focusNode,
  }) : super(key: key);

  @override
  State<PrimaryDropDownField> createState() => _PrimaryDropDownFieldState();
}

class _PrimaryDropDownFieldState extends State<PrimaryDropDownField> {
  final TextEditingController _controller = TextEditingController();
  // final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  final GlobalKey _widgetKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();
  ScrollController scrollController = ScrollController();
  List data = [];
  Function(void Function())? set;

  @override
  void initState() {
    if (widget.preFilled != null && widget.preFilled!.isNotEmpty) {
      _controller.text = widget.preFilled!;
    }

    widget.focusNode?.addListener(() {
      print("focus : ${widget.readOnly}");
      if (widget.readOnly == null ? true : !widget.readOnly!) {
        if (widget.focusNode!.hasFocus) {
          _overlayEntry = _createOverlayEntry();
          if (_overlayEntry != null) {
            Overlay.of(context).insert(_overlayEntry!);
          }
        } else {
          if (_overlayEntry != null) {
            _overlayEntry!.remove();
          }
        }
      } else {
        if (_overlayEntry != null) {
          _overlayEntry!.remove();
        }
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void didUpdateWidget(oldWidget) {
    if (widget.preFilled != null) {
      _controller.text = widget.preFilled!;
    }
  }

  final GlobalKey key = GlobalKey();

  OverlayEntry _createOverlayEntry() {
    Size fieldSize = (context.findRenderObject() as RenderBox).size;
    double positionW = (_widgetKey.currentContext!.findRenderObject() as RenderBox).localToGlobal(Offset.zero).dy;
    double screenH = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    double boxSize = 0;
    return OverlayEntry(
      builder: (context) {
        return StatefulBuilder(
          builder: (context, se) {
            set = se;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (key.currentContext != null) {
                final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
                if (boxSize != renderBox.size.height) {
                  boxSize = renderBox.size.height;
                  if (set != null) {
                    set!(() {});
                  }
                }
              }
            });

            bool tob = screenH - (positionW + fieldSize.height) > boxSize;

            return Positioned(
              width: fieldSize.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, tob ? fieldSize.height - 30 : -boxSize),
                child: Material(
                  key: key,
                  color: Colors.transparent,
                  child: Container(
                    constraints: BoxConstraints(maxHeight: (screenH / 2) - fieldSize.height - 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        bottom: tob ? const Radius.circular(20) : const Radius.circular(0),
                        top: !tob ? const Radius.circular(20) : const Radius.circular(0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: tob ? const Offset(3, 3) : const Offset(-3, -3),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: ScrollbarTheme(
                      data: ScrollbarThemeData(
                        thumbColor: MaterialStateProperty.all<Color>(Colors.grey),
                        thickness: MaterialStateProperty.all<double>(2),
                        radius: const Radius.circular(8),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                        mainAxisMargin: 20,
                      ),
                      child: Scrollbar(
                        controller: scrollController,
                        child: ListView.builder(
                          shrinkWrap: true,
                          controller: scrollController,
                          reverse: !tob,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return childrenWidget(index);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    data = widget.items;
    return PrimaryTextField(
      link: _layerLink,
      controller: _controller,
      isRequired: widget.isRequired,
      fieldKey: _widgetKey,
      readOnly:
          widget.readOnly ??
          (widget.isSearchable == null
              ? true
              : widget.isSearchable!
              ? false
              : true),
      labelText: widget.labelText,
      labelColor: widget.labelColor,
      labelSize: widget.labelSize,
      validator: widget.validator,
      hintText: widget.hintText,
      padding: widget.padding,
      textSize: widget.textSize,
      radius: widget.radius,
      textColor: Colors.black,
      borderColor: widget.borderColor,
      errorColor: widget.errorColor,
      backgroundColor: widget.backgroundColor,
      onChanged:
          !(widget.readOnly ?? false) && !(widget.isSearchable == null ? true : !widget.isSearchable!)
              ? (value) {
                if (value.isEmpty) {
                  data = widget.items;
                  widget.onChanged(null);
                }
                if (value.isNotEmpty) {
                  data = [];
                  for (var i in widget.items) {
                    String j = (i is String) ? i : (i as Map)[widget.valueKey];
                    if (j.toString().replaceAll(" ", "").toLowerCase().contains(value.replaceAll(" ", "").toLowerCase().toString())) {
                      data.add(i);
                    }
                  }
                }
                if (set != null) {
                  set!(() {});
                }
              }
              : null,
      suffix: Row(
        mainAxisSize: MainAxisSize.min,
        children: [widget.suffix ?? Icon(!widget.focusNode!.hasFocus ? Icons.arrow_drop_down : Icons.arrow_drop_up), SizedBox(width: 10)],
      ),
      icon: widget.icon,
      focusNode: widget.focusNode,
      onTap: () {
        if (widget.focusNode!.hasFocus) {
          widget.focusNode?.unfocus();
        }
      },
    );
  }

  Widget childrenWidget(int index) {
    String? i = (data[index] is String) ? data[index] : (data[index] as Map)[widget.valueKey];
    return GestureDetector(
      onTap: () {
        widget.focusNode?.unfocus();
        _controller.text = i ?? "Null";
        widget.onChanged(data[index]);
      },
      child: Container(
        color: i == widget.preFilled ? AppColors.outLineColor : Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Row(children: [Text('$i', style: TextStyle(color: i == widget.preFilled ? AppColors.primaryColor : Colors.black))]),
      ),
    );
  }
}

class PrimaryTextField extends StatelessWidget {
  final IconData? icon;
  final String labelText;
  final Color? labelColor;
  final Color? backgroundColor;
  final Color? textColor;
  final String? hintText;
  final String? endedText;
  final bool readOnly;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final Widget? suffix;
  final Widget? suffixWidget;
  final Widget? prefix;
  // final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final int maxLine;
  final EdgeInsetsGeometry? padding;
  final LayerLink? link;
  final Key? fieldKey;
  final FocusNode? focusNode;
  final bool? isRequired;
  final double? radius;
  final double? labelSize;
  final double? textSize;
  final int? maxLength;
  final Color? borderColor;
  final Color? errorColor;
  final FontWeight? textWeight;
  final bool? capitalize;

  const PrimaryTextField({
    super.key,
    this.icon,
    required this.labelText,
    this.hintText,
    this.labelColor,
    this.backgroundColor,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffix,
    this.prefix,
    // this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.validator,
    this.maxLine = 1,
    this.readOnly = false,
    this.enabled = true,
    this.endedText,
    this.padding,
    this.link,
    this.fieldKey,
    this.focusNode,
    this.isRequired,
    this.radius,
    this.textSize,
    this.labelSize,
    this.suffixWidget,
    this.textColor,
    this.onSubmitted,
    this.maxLength,
    this.borderColor,
    this.errorColor,
    this.textWeight,
    this.capitalize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText.isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (labelText.isNotEmpty) ...{
                Text(
                  labelText,
                  // maxLines: 1,
                  // softWrap: false,
                  style: TextStyle(color: labelColor ?? Colors.grey.shade700, fontSize: labelSize ?? 12, fontWeight: FontWeight.w500),
                ),
                if (isRequired ?? false) ...[
                  SizedBox(width: 8),
                  Text(
                    (isRequired ?? false) ? "*" : "",
                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ],
              },
              const Spacer(),
              endedText != null
                  ? Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      endedText!,
                      textScaler: TextScaler.linear(1),
                      style: TextStyle(color: labelColor ?? Colors.grey.shade700, fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                  )
                  : const SizedBox(),
            ],
          ),
          SizedBox(height: 6),
        ] else
          SizedBox.shrink(),
        CompositedTransformTarget(
          link: link ?? LayerLink(),
          child: TextFormField(
            key: fieldKey,
            focusNode: focusNode,
            textCapitalization: (capitalize ?? false) ? TextCapitalization.characters : TextCapitalization.none,
            autocorrect: false,
            autofocus: false,
            style: TextStyle(
              color: textColor ?? Colors.black,
              fontSize: (textSize ?? 16) / MediaQuery.of(context).textScaleFactor,
              fontWeight: textWeight ?? FontWeight.w400,
            ),
            maxLines: maxLine,
            enabled: enabled,
            controller: controller,
            keyboardType: keyboardType,
            onChanged: onChanged,
            validator: validator,
            readOnly: readOnly,
            obscuringCharacter: '*',
            cursorColor: Colors.black,
            obscureText: obscureText,
            // inputFormatters: inputFormatters,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onTap: onTap,
            maxLength: maxLength,
            onFieldSubmitted: onSubmitted,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: icon != null ? Icon(icon, color: Colors.grey.shade700) : prefix,
              filled: true,
              isDense: true,
              hintStyle: TextStyle(color: Colors.grey.shade700),
              enabledBorder: _border(borderColor ?? const Color(0xffE1E1E1)),
              fillColor: backgroundColor ?? Colors.white,
              border: _border(borderColor ?? Colors.grey),
              contentPadding: padding,
              counterText: "",
              suffixIconConstraints: BoxConstraints(maxHeight: 20),
              focusedBorder: _border(borderColor ?? Colors.black),
              errorBorder: _border(errorColor ?? Colors.red),
              focusedErrorBorder: _border(errorColor ?? Colors.red),
              suffixIcon: suffix,
              suffix: suffixWidget,
              errorMaxLines: 2,
              errorStyle: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(borderSide: BorderSide(color: color, width: 1), borderRadius: BorderRadius.circular(radius ?? 8));
  }
}
