import 'package:injectable/injectable.dart';
import 'package:tinder/data/api/api_endpoint.dart';
import 'package:tinder/data/api/models/query/user_params.dart';
import 'package:tinder/data/api/rest_client.dart';
import 'package:tinder/data/services/base_service.dart';

@injectable
class UserService extends BaseService {
  UserService(RestClient restClient) : super(restClient);

  Future<Map<String, dynamic>> getListUsers(UserParams params) async {
    final response = await get(UsersApi.list, queryParameters: params.toJson());
    return response;
  }

  Future<Map<String, dynamic>> getDetail(String id) async {
    final response = await get(UsersApi.detail.replaceAll("{id}", id));
    return response;
  }
}
