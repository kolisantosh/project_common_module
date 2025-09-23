import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_common_module/core/utils/src/size_extension.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/src/screen_util.dart';

class CommonIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String imagePath;
  final double? height;
  final double? width;
  final bool widthFull;
  final Color? color;
  final bool? border;
  final bool isLoading;
  final Color? textColor;
  final TextStyle? style;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Widget? child;
  final BorderRadius? borderRadius;

  const CommonIconButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.imagePath,
    this.height,
    this.color,
    this.style,
    this.margin,
    this.borderRadius,
    this.width,
    this.textColor,
    this.widthFull = true,
    this.padding,
    this.border = false,
    this.isLoading = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin ?? EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      width: width ?? (widthFull ? ScreenUtil().screenWidth : null),
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(10.w),
        // color: color ?? Constants.primaryColor,
        color: isLoading ? AppColors.primaryDullColor : (color ?? AppColors.primaryColor),
        border: border == false ? null : Border.all(color: AppColors.outLineColor, width: 1.5.w),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading) SizedBox(height: 20.w, width: 20.w, child: CircularProgressIndicator(strokeWidth: 2.5.w, color: Colors.white)),
            if (imagePath.isNotEmpty && !isLoading)
              SvgPicture.asset(
                imagePath,
                height: widthFull ? 23.h : 18.h,
                colorFilter: ColorFilter.mode(textColor ?? Colors.white, BlendMode.srcIn),
              ).paddingOnly(right: 10.w),
            Flexible(
              child: Text(
                isLoading ? "" : title,
                overflow: TextOverflow.ellipsis,
                style: style ?? GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 18.sp, color: textColor ?? Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
