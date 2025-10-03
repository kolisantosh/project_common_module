import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_common_module/core/utils/src/size_extension.dart';

import '../../core/constants/app_colors.dart';
import 'common_divider.dart';

class CommonAppBar extends StatelessWidget {
  final String title;
  final String? imagePath;
  final bool center;
  final bool backIcon;
  final bool suffix;
  final String suffixIcon;
  final String backArrow;
  final double? suffixRadius;
  final Color? color;
  final Color? suffixColor;
  final VoidCallback onTap;
  final VoidCallback? onTapFilter;
  final EdgeInsets? padding;
  final bool bottomTab;
  final bool removeShadow;
  final Widget? tabBar;
  final TextStyle? style;

  const CommonAppBar({
    super.key,
    required this.title,
    required this.center,
    this.imagePath,
    required this.onTap,
    this.onTapFilter,
    this.suffixColor,
    this.bottomTab = false,
    this.suffixRadius,
    this.tabBar,
    required this.backIcon,
    this.suffix = false,
    this.suffixIcon = '',
    this.backArrow = '',
    this.padding,
    this.color,
    this.style,
    this.removeShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 20.h),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        boxShadow:
            removeShadow
                ? [
                  BoxShadow(
                    color: const Color(0x1a8b8b8b),
                    spreadRadius: 1.r,
                    blurRadius: 24.r,
                    offset: const Offset(0.0, 11.0),
                    // offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]
                : null,
      ),
      child: Column(
        children: [
          tabBar != null ? Container() : SizedBox(height: MediaQuery.of(context).viewPadding.top),
          title.isNotEmpty
              ? Row(
                children: [
                  backIcon
                      ? GestureDetector(
                        onTap: onTap,
                        child: Padding(
                          padding: padding ?? EdgeInsets.all(15.0.w),
                          child: SvgPicture.asset(backArrow, height: 60.w, width: 60.w),
                        ),
                      ).paddingOnly(right: 37.w, left: 18.w)
                      : SizedBox(width: MediaQuery.of(context).viewPadding.top / 1.3),
                  Expanded(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style:
                          style ??
                          GoogleFonts.inter(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w900,
                            // fontFamily: "DMSans-Bold",
                            color: AppColors.headerTextColor,
                          ),
                    ),
                  ),
                  suffix
                      ? IconButton(
                        onPressed: onTapFilter,
                        icon: Container(
                          height: 93.w,
                          width: 104.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(suffixRadius ?? 20),
                            color: suffixColor ?? AppColors.backgroundColor1,
                          ),
                          child: SvgPicture.asset(suffixIcon, height: 23.w, width: 23.w, fit: BoxFit.scaleDown),
                        ),
                      ).paddingOnly(right: 17.w, left: 18.w)
                      : SizedBox(width: MediaQuery.of(context).viewPadding.top / 1.3),
                ],
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(),
                  suffix
                      ? IconButton(
                    onPressed:onTapFilter,
                        icon: Container(
                          height: 93.w,
                          width: 104.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(suffixRadius ?? 20.r),
                            color: AppColors.backgroundColor1,
                          ),
                          child: SvgPicture.asset(suffixIcon, height: 50.w, width: 50.w, fit: BoxFit.scaleDown),
                        ),
                      ).paddingOnly(right: 17.w, left: 18.w)
                      : SizedBox(width: MediaQuery.of(context).viewPadding.top / 1.3),
                ],
              ),
          bottomTab
              ? SizedBox(child: tabBar!)
              : Column(children: [SizedBox(height: MediaQuery.of(context).viewPadding.top / 2), if (removeShadow) const AppDivider()]),
        ],
      ),
    );
  }
}
