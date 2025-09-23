import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/utils/utils.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;
  const BaseScreen({
    super.key,
    required this.child,
    this.resizeToAvoidBottomInset = true,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return GestureDetector(
      onTap: () {
        Utils().hideKeyboard();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: color ?? null,
        body: SafeArea(top: false, bottom: true, child: child),
        // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: MediaQuery.of(context).viewInsets.bottom != 0 ? null : floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
