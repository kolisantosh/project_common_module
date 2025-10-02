import 'package:flutter/material.dart';
import 'package:project_common_module/core/utils/src/size_extension.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/src/screen_util.dart';

class AppDivider extends StatelessWidget {
  final bool boxShadow;
  final double? height;
  final double? width;
  const AppDivider({super.key,this.height,this.width, this.boxShadow = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 1.h,
      width: width ?? ScreenUtil().screenWidth,
      decoration: BoxDecoration(
        color: AppColors.textDisableColor.withOpacity(0.3),
        boxShadow:
            boxShadow == false
                ? null
                : [
                  BoxShadow(
                    color: const Color(0x1a8B8B8B).withOpacity(0.3),
                    spreadRadius: 1.5.r,
                    blurRadius: 24.r,
                    offset: const Offset(0, 11), // changes position of shadow
                  ),
                ],
      ),
    );
  }
}
