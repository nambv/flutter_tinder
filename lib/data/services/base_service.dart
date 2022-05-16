import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/exception/api_exception.dart';
import '../api/rest_client.dart';

class BaseService {
  final RestClient restClient;

  BaseService(this.restClient);

  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, String>? headers}) async {
    final response = await restClient.dio.get(path,
        queryParameters: queryParameters, options: Options(headers: headers));
    return _handleResponse(response);
  }

  Future<dynamic> post(String path,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers}) async {
    final response = await restClient.dio.post(path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers));
    return _handleResponse(response);
  }

  Future<dynamic> patch(String path,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers}) async {
    final response = await restClient.dio.patch(path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers));
    return _handleResponse(response);
  }

  Future<dynamic> upload(String path,
      {FormData? data,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers}) async {
    final response = await restClient.dio.post(path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers));
    return _handleResponse(response);
  }

  Future<dynamic> put(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers}) async {
    final response = await restClient.dio.put(path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers));
    return _handleResponse(response);
  }

  Future<dynamic> delete(String path,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers}) async {
    final response = await restClient.dio.delete(path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers));
    return _handleResponse(response);
  }

  Future<dynamic> download(String path, String savePath) async {
    final response = await restClient.dio.download(path, savePath);
    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data;
    }

    print('response.data["errors"]: ${json.encode(response.data["errors"])}');
    throw ApiException.fromJson(response.data["errors"]);
  }
}
