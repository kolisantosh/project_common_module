import 'package:flutter/material.dart';
import 'package:project_common_module/views.dart';

class CommonBGWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final Color? color;
  final Color? appBarColor;
  final Widget? floatingActionButton;
  final Widget? tabBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool resizeToAvoidBottomInset;
  final bool backIcon;
  final bool suffix;
  final String backArrow;
  final String suffixIcon;
  final String splashBg;
  final bool bottom;
  final bool shadow;
  final VoidCallback? getBack;
  final VoidCallback? getFilterTab;
  final TextStyle? style;

  const CommonBGWidget({
    super.key,
    required this.child,
    this.resizeToAvoidBottomInset = true,
    this.backIcon = true,
    this.suffix = false,
    this.backArrow = '',
    this.suffixIcon = '',
    this.splashBg = '',
    this.bottom = false,
    this.shadow = false,
    this.tabBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.color,
    required this.title,
    this.getBack,
    this.style,
    this.getFilterTab,
    this.appBarColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: floatingActionButton,
      child: Stack(
        children: [
          Positioned.fill(child: Image.asset(splashBg, fit: BoxFit.cover)),

          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(left: 50.w, right: 50.w, top: 20.h, bottom: 170.h),
              child: CommonContainer(
                title: title,
                color: Colors.transparent,
                appBarColor: appBarColor,
                backIcon: backIcon,
                suffix: suffix,
                style: style,
                getBack:
                    getBack ??
                    () {
                      Navigator.pop(context);
                    },
                backArrow: backArrow,
                getFilterTab: getFilterTab,
                suffixIcon: suffixIcon,
                bottom: bottom,
                shadow: shadow,
                tabBar: tabBar,
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
