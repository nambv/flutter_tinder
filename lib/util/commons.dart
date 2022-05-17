import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:tinder/data/api/exception/api_exception.dart';
import 'package:tinder/data/services/navigation_service.dart';
import 'package:tinder/tinder.dart';

String getErrorMessage(dynamic error, StackTrace? stackTrace) {
  if (error is ApiException) {
    return error.error;
  }

  if (error is PlatformException) {
    return error.message!;
  }

  if (error is DioError) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      switch (error.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          return context.localizations.timeoutErrorMsg;
        case DioErrorType.other:
          return context.localizations.networkErrorMsg;
        default:
          return error.response?.data["error"];
      }
    }
  }

  return error.toString().replaceAll('Exception: ', '');
}
