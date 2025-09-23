import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_common_module/core/utils/src/size_extension.dart';

void showToast({
  required String msg,
  // Toast length = Toast.LENGTH_SHORT,
  // ToastGravity gravity = ToastGravity.BOTTOM,
  int timeInSecForIosWeb = 1,
  Color backgroundColor = Colors.black,
  Color textColor = Colors.white,
  double fontSize = 16.0,
  context,
}) {
  // Fluttertoast.showToast(
  //   msg: msg,
  //   toastLength: length,
  //   gravity: gravity,
  //   timeInSecForIosWeb: timeInSecForIosWeb,
  //   backgroundColor: backgroundColor,
  //   textColor: textColor,
  //   fontSize: fontSize,
  // );

  final snackBar = SnackBar(content: Text(msg, style: GoogleFonts.inter(color: textColor)), backgroundColor: backgroundColor);
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(snackBar);
}

void showSnackBarTop(BuildContext context, String message, {bool error = false}) {
  final overlay = Overlay.of(context);

  if (overlay == null) return;

  final overlayEntry = OverlayEntry(
    builder:
        (context) => Positioned(
          top: MediaQuery.of(context).padding.top + 20,
          left: 20,
          right: 20,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(color: error ? Colors.red : Colors.green, borderRadius: BorderRadius.circular(8.r)),
              child: Text(message, style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp)),
            ),
          ),
        ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}

void showErrorMessage(String message, context) {
  showErrorSnackBarMessage(message, context);
}

void showErrorSnackBarMessage(String message, context) {
  final snackBar = SnackBar(content: Text(message, style: GoogleFonts.inter(color: Colors.white)), backgroundColor: Colors.red);
  final scaffold = ScaffoldMessenger.of(context);
  scaffold
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
