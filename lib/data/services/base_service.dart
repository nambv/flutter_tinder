import 'package:dio/dio.dart';

import '../api/exception/api_exception.dart';
import '../api/rest_client.dart';

class BaseService {
  final RestClient restClient;

  BaseService(this.restClient);

  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    final response =
        await restClient.dio.get(path, queryParameters: queryParameters);
    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data;
    }

    throw ApiException.fromJson(response.data);
  }
}
