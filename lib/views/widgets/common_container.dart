import 'package:flutter/material.dart';

import 'base_widget.dart';
import 'common_appbar.dart';

class CommonContainer extends StatelessWidget {
  final Widget child;
  final String title;
  final Color? color;
  final Color? appBarColor;
  final Color? suffixColor;
  final Widget? floatingActionButton;
  final Widget? tabBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool resizeToAvoidBottomInset;
  final bool backIcon;
  final bool suffix;
  final String suffixIcon;
  final String backArrow;
  final bool bottom;
  final bool shadow;
  final bool scroll;
  final TextStyle? style;

  final VoidCallback? getBack;
  final VoidCallback? getFilterTab;
  const CommonContainer({
    super.key,
    required this.child,
    this.resizeToAvoidBottomInset = true,
    this.backIcon = true,
    this.suffix = false,
    this.suffixIcon = '',
    this.backArrow = '',
    this.bottom = false,
    this.shadow = true,
    this.scroll = true,
    this.suffixColor,
    this.style,
    this.tabBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.color,
    required this.title,
    this.getBack,
    this.getFilterTab,
    this.appBarColor,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      color: color,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      child: Column(
        children: [
          Container(
            // color: Colors.black,
            child: CommonAppBar(
              title: title,
              color: appBarColor,
              onTap:
                  getBack ??
                  () {
                    Navigator.pop(context);
                  },
              backArrow: backArrow,
              onTapFilter: getFilterTab,
              center: false,
              backIcon: backIcon,
              suffix: suffix,
              suffixIcon: suffixIcon,
              suffixColor: suffixColor,
              bottomTab: bottom,
              removeShadow: shadow,
              tabBar: tabBar,
              padding: EdgeInsets.zero,
              style: style,
            ),
          ),
          bottom
              ? Expanded(flex: 1, child: child)
              : scroll == false
              ? Expanded(flex: 1, child: child)
              : Expanded(flex: 1, child: SingleChildScrollView(physics: const ClampingScrollPhysics(), child: child)),
        ],
      ),
    );
  }
}
