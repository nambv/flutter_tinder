import 'package:injectable/injectable.dart';
import 'package:tinder/bases/base_model.dart';
import 'package:tinder/data/api/models/query/user_params.dart';
import 'package:tinder/data/api/models/user.dart';
import 'package:tinder/data/repositories/user_repository.dart';
import 'package:tinder/util/commons.dart';
import 'package:tinder/util/enums.dart';

@injectable
class CardsModel extends BaseModel {
  int page = 1;
  List<User> users = [];
  UserRepository repository;

  CardsModel(this.repository);

  @override
  loadData() async {
    setState(ViewState.loading);

    try {
      users = await repository.listUsers(UserParams(page: page));
      setState(ViewState.loaded);
      getDetail(0, users.first.id);
    } catch (error, stacktrace) {
      errorMsg = getErrorMessage(error, stacktrace);
      setState(ViewState.error, error: errorMsg);
    }
  }

  getDetail(int index, String id) async {
    final user = await repository.getDetail(id);
    users[index].setDateOfBirth(user.dateOfBirth);
  }

  clearUsers() {
    users.clear();
    notifyListeners();
  }
}
