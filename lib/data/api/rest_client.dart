import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tinder/data/api/api_endpoint.dart';

typedef ApiErrorCallback = Function(
    DioError e, ErrorInterceptorHandler handler);

const kTimeout = 20000; // in milliseconds

@singleton
class RestClient {
  late Dio dio;

  RestClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: kTimeout,
        receiveTimeout: kTimeout,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
    ));
  }

  void errorCallback(ApiErrorCallback errorCallback) {
    dio.interceptors.add(InterceptorsWrapper(onError: errorCallback));
  }
}
