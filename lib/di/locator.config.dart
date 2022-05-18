// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/api/rest_client.dart' as _i4;
import '../data/repositories/user_repository.dart' as _i6;
import '../data/services/navigation_service.dart' as _i3;
import '../data/services/user_service.dart' as _i5;
import '../ui/screens/cards/cards_model.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.NavigationService>(_i3.NavigationService());
  gh.singleton<_i4.RestClient>(_i4.RestClient());
  gh.factory<_i5.UserService>(() => _i5.UserService(get<_i4.RestClient>()));
  gh.singleton<_i6.UserRepository>(_i6.UserRepository(get<_i5.UserService>()));
  gh.factory<_i7.CardsModel>(() => _i7.CardsModel(get<_i6.UserRepository>()));
  return get;
}
