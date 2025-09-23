import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../core/constants/topic.dart';
import '../core/utils/get_storage_data.dart';
import '../core/utils/toast.dart';
import '../core/utils/utils.dart';
import '../views/widgets/loader.dart';

class HttpUtil {
  factory HttpUtil(String token, bool isLoading, BuildContext context) => _instance(token, isLoading, context);

  static HttpUtil _instance(token, isLoading, context) => HttpUtil._internal(token: token, isLoading: isLoading, context: context);

  late Dio dio;
  static CancelToken cancelToken = CancelToken();
  GetStorageData getStorageData = GetStorageData();

  String apiUrl = TopicAPI.baseUrl;
  Utils utils = Utils();

  HttpUtil._internal({String? token, bool? isLoading, BuildContext? context}) {
    BaseOptions options = BaseOptions(
      // baseUrl: apiUrl,
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 10000),
      headers: {'authorization': token},
      contentType: 'application/json',
      responseType: ResponseType.json,
    );

    dio = Dio(options);
    CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    dio.interceptors.add(LogInterceptor(request: false, requestBody: false, responseBody: true));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (isLoading!) {
            // showLoader();
          }
          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          // print("response=====> ${response}");
          if (isLoading!) {
            closeLoader(context);
          }
          return handler.next(response); // continue
        },
        onError: (DioException e, handler) async {
          if (kDebugMode) {
            print("params -------->>> ${e.type} ${e.response?.statusCode}");
          }

          if (isLoading!) {
            closeLoader(context);
          }

          // Handle specific DioError types
          if (e.type == DioExceptionType.connectionError) {
            handleConnectionError(e, context);
          } else if (e.response?.statusCode == 401) {
            // try {
            //   DashboardCubit dashboardCubit = GetIt.I<DashboardCubit>();
            //   if (dashboardCubit.timerDelay1 != null) dashboardCubit.timerDelay1!.cancel();
            // } catch (e) {
            //   print(e.toString());
            // }
            // getStorageData.remove(getStorageData.isLogin);
            // getStorageData.unsubscribeFromAllTopics();
            // getStorageData.clear();
            //
            // Navigator.of(
            //   navigatorKey.currentContext!,
            // ).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => const LoginScreen()), (Route<dynamic> route) => false);
          } else if (e.response?.statusCode == 403) {
            await handleUnauthorizedError(e, context);
          } else {
            print("Dio Exception :=============>>>>>> $e");
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<void> handleConnectionError(DioException e, context) async {
    if (e.message!.contains("Connection refused")) {
      showErrorMessage("Failed to connect to the server. Please try again later.", context);
    } else {
      showErrorMessage(createErrorEntity(e).message, context);
      showErrorMessage("Failed to connect to the server. Please try again later.", context);
    }
  }

  Future<void> handleUnauthorizedError(DioException e, context) async {
    var serverUrl = await getStorageData.readString(getStorageData.serverIP);
    if (e.requestOptions.uri.toString().contains("$http$serverUrl${TopicAPI.refreshToken}")) {
      // Navigate to login screen or show relevant UI

      // getStorageData.remove(getStorageData.isLogin);
      // getStorageData.unsubscribeFromAllTopics();
      // getStorageData.clear();
      //
      // Navigator.of(
      //   navigatorKey.currentContext!,
      // ).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => const LoginScreen()), (Route<dynamic> route) => false);
    } else {
      String? token = await refreshToken(context);
      if (token != null) {
        dio.options.headers['authorization'] = token;
        // await retry(e.requestOptions, token);
        // Handle retry response if needed
      }
    }
  }

  Future<void> handleOtherErrors(DioException e, context) async {
    showErrorMessage(createErrorEntity(e).message, context);
  }

  Future<String?> refreshToken(context) async {
    try {
      var serverUrl = await getStorageData.readString(getStorageData.serverIP);
      final response = await dio.post(
        "$http$serverUrl${TopicAPI.refreshToken}",
        queryParameters: {
          // 'refreshToken': await getStorageData.readString(getStorageData.token),
        },
      );

      if (response.statusCode == 200) {
        String newAccessToken = response.data['token'];
        await getStorageData.saveString(getStorageData.token, newAccessToken);
        return newAccessToken;
      }
    } catch (e) {
      showErrorMessage("Failed to refresh token. Please log in again.", context);
    }
    return null;
  }

  Future<Response<dynamic>> retry(RequestOptions requestOptions, String newToken) async {
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'authorization': newToken, // Use the new token
      },
    );
    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  static void cancelRequests() {
    cancelToken.cancel("cancelled");
  }

  // RESTful get and post methods remain unchanged
  Future get(String path, {Map<String, dynamic>? queryParameters, Options? options}) async {
    // print("get=====> $path ====> $queryParameters");
    var response = await dio.get(path, queryParameters: queryParameters, options: options, cancelToken: CancelToken());
    return response.data;
  }

  Future post(String path, {String? data, Map<String, dynamic>? queryParameters, Options? options}) async {
    // print("post=====> $path ====> $queryParameters");
    var response = await dio.post(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken);
    return response.data;
  }

  ErrorEntity createErrorEntity(DioException error) {
    // Handle different types of DioError
    switch (error.type) {
      case DioExceptionType.cancel:
        return ErrorEntity(code: -1, message: "Request to server was cancelled");

      case DioExceptionType.connectionTimeout:
        return ErrorEntity(code: -2, message: "Connection timeout with server");

      case DioExceptionType.sendTimeout:
        return ErrorEntity(code: -3, message: "Send timeout in connection with server");

      case DioExceptionType.receiveTimeout:
        return ErrorEntity(code: -4, message: "Receive timeout in connection with server");
      // case DioExceptionType.connectionError:
      //   return ErrorEntity(code: -5, message: "Can't connect with server");

      case DioExceptionType.badResponse:
        // Handle HTTP error codes (4xx, 5xx) in a more detailed way
        try {
          if (kDebugMode) {
            print("Bad response error ====> ${error.response!.data}");
          }
          int errCode = error.response?.statusCode ?? 0;
          String errString =
              error.response?.data != null && error.response!.data['error'] != null
                  ? error.response!.data['message'] // Use message from API if available
                  // ? error.response!.data['error'][0]['msg'] // Use message from API if available
                  : "Unknown error occurred"; // Default error message if no message available

          return _mapHttpErrorToEntity(errCode, errString);
        } on Exception catch (_) {
          return ErrorEntity(code: 0, message: "An error occurred while processing the response.");
        }

      case DioExceptionType.unknown:
        // Handle unknown errors like network issues
        if (error.message!.contains("SocketException")) {
          return ErrorEntity(code: -6, message: "Your internet connection is unavailable. Please check your network.");
        } else if (error.message!.contains("Software caused connection abort")) {
          return ErrorEntity(code: -7, message: "Your internet connection is unstable. Please try again later.");
        }
        return ErrorEntity(code: -8, message: "Oops, something went wrong.");

      default:
        if (error.message!.contains("SocketException") || error.message!.contains("connection errored")) {
          return ErrorEntity(code: -6, message: "Your internet connection is unavailable. Please check your network.");
        } else if (error.message!.contains("connectionError")) {
          return ErrorEntity(code: -5, message: "Can't connect with server");
        } else if (error.message!.contains("Software caused connection abort")) {
          return ErrorEntity(code: -7, message: "Your internet connection is unstable. Please try again later.");
        }
        return ErrorEntity(code: -8, message: "Oops, something went wrong.");
    }
  }

  // Helper function to map HTTP error codes to user-friendly messages
  ErrorEntity _mapHttpErrorToEntity(int statusCode, String message) {
    switch (statusCode) {
      case 400:
        return ErrorEntity(code: statusCode, message: "Bad request. Please check the syntax.");
      case 401:
        return ErrorEntity(code: statusCode, message: "Unauthorized access. Please log in again.");
      case 403:
        return ErrorEntity(code: statusCode, message: "Forbidden access. You don't have permission.");
      case 404:
        return ErrorEntity(code: statusCode, message: "Not found. The requested resource is not available.");
      case 500:
        return ErrorEntity(code: statusCode, message: "Internal server error. Please try again later.");
      case 502:
        return ErrorEntity(code: statusCode, message: "Bad gateway. The server is not responding.");
      case 503:
        return ErrorEntity(code: statusCode, message: "Service unavailable. Please try again later.");
      case 504:
        return ErrorEntity(code: statusCode, message: "Gateway timeout. The server took too long to respond.");
      default:
        return ErrorEntity(code: statusCode, message: message);
    }
  }
}

class ErrorEntity implements Exception {
  int code;
  String message;

  ErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message.isEmpty) return "Exception";
    return "Exception: code $code, $message";
  }
}
