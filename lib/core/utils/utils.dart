import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  /// <<< To get device type --------- >>>
  static String getDeviceType() {
    if (Platform.isAndroid) {
      return 'Android';
    } else {
      return 'iOS';
    }
  }

  /// <<< To check email valid or not --------- >>>
  static bool emailValidator(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(email)) {
      return true;
    }
    return false;
  }

  /// <<< To check phone valid or not --------- >>>
  static bool phoneValidator(String contact) {
    String p = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(contact)) {
      return true;
    }
    return false;
  }

  /// <<< To check password valid or not --------- >>>
  static bool passwordValidator(String contact) {
    String p = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(contact)) {
      return true;
    }
    return false;
  }

  /// <<< To check IP valid or not --------- >>>
  static bool isValidIP(String ip) {
    String ipWithPortRegex = r"^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?):([0-9]{1,5})$";

    RegExp regExp = RegExp(ipWithPortRegex);

    return regExp.hasMatch(ip);
  }

  /// <<< To check data, string, list, object are empty or not --------- >>>
  static bool isValidationEmpty(String? str) {
    var val = str.toString().toLowerCase();
    if (val == null || val.isEmpty || val == "null") {
      return true;
    } else {
      return false;
    }
  }

  /// <<< hide keyboard --------- >>>
  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// <<< To show snackBar massage  --------- >>>
  void showSnackBar({required BuildContext context, required String message, bool? isOk = false}) {
    Future<void>.delayed(Duration.zero, () {
      Get.snackbar(
        "",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: isOk! ? Colors.green.shade600 : Colors.red.shade600,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        isDismissible: true,
        padding: const EdgeInsets.only(bottom: 15, top: 10, left: 15, right: 15),
        titleText: Container(),
      );
    });
  }
}
