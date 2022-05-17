import 'package:injectable/injectable.dart';
import 'package:tinder/data/api/models/query/user_params.dart';
import 'package:tinder/data/api/models/user.dart';
import 'package:tinder/data/services/user_service.dart';

@singleton
class UserRepository {
  UserService service;

  UserRepository(this.service);

  Future<List<User>> listUsers(UserParams params) async {
    final response = await service.getListUsers(params);
    final list =
        List<User>.from(response["data"].map((item) => User.fromJson(item)))
            .toList();
    return list;
  }

  Future<User> getDetail(String id) async {
    final response = await service.getDetail(id);
    return User.fromJson(response);
  }
}
