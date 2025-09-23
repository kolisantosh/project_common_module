import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_common_module/core/utils/src/size_extension.dart';

showLoader(context) {
  Widget progressIndicator;
  if (kIsWeb) {
    progressIndicator = const CircularProgressIndicator();
  } else {
    progressIndicator = Platform.isAndroid ? const CircularProgressIndicator() : CupertinoActivityIndicator(radius: 14.r);
  }

  return showDialog(
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.2),
    context: context,
    builder: (_) => Center(child: progressIndicator),
  );
}

closeLoader(context) {
  Navigator.of(context).pop();
}
