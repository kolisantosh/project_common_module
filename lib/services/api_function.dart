import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../core/utils/get_storage_data.dart';
import 'api_class.dart';

class APIFunction {
  GetStorageData getStorageData = GetStorageData();
  String? _cachedToken;

  Future<String> getToken() async {
    _cachedToken ??= await getStorageData.readString(getStorageData.token);
    return _cachedToken!;
  }

  Future<dynamic> apiCall({required String apiName, String? params, String? token = "", bool isLoading = false, context}) async {
    // Debugging logs to check parameters
    final token = await getToken(); // Use the cached token if available.

    // Check if token or params are null and provide defaults
    final safeParams = params ?? ""; // Default to empty string if null
    final safeToken = token ?? ""; // Default to empty string if null

    try {
      var response = await HttpUtil(safeToken, isLoading, context).post(apiName, data: safeParams);

      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error during API call: $e'); // Add more detailed error logging
      }

      throw Exception(e);
      // Show error message to the user
      // utils.showSnackBar(context: context, message: e.toString());
    }
  }
}

class GetAPIFunction {
  GetStorageData getStorageData = GetStorageData();
  String? _cachedToken;

  Future<String> getToken() async {
    _cachedToken ??= await getStorageData.readString(getStorageData.token);
    return _cachedToken!;
  }

  Future<dynamic> apiCall({required String apiName, String? params, String? token = "", bool isLoading = true, context}) async {
    // Debugging logs to check parameters
    final token = await getToken(); // Use the cached token if available.

    // Check if token or params are null and provide defaults
    final safeParams = params ?? ""; // Default to empty string if null
    final safeToken = token ?? ""; // Default to empty string if null
    if (kDebugMode) {
      print("token ====> $safeToken");
    }
    try {
      var response = await HttpUtil(
        safeToken,
        isLoading,
        context,
      ).get(apiName, queryParameters: safeParams.isEmpty ? null : jsonDecode(safeParams));
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error during API call: $e'); // Add more detailed error logging
      }

      throw Exception(e);
      // Show error message to the user
      // utils.showSnackBar(context: context, message: e.toString());
    }
  }
}
