import 'package:json_annotation/json_annotation.dart';

part 'user_params.g.dart';

@JsonSerializable()
class UserParams {
  @JsonKey()
  int limit;

  @JsonKey()
  int page;

  UserParams({this.limit = 10, this.page = 1});

  factory UserParams.fromJson(Map<String, dynamic> json) =>
      _$UserParamsFromJson(json);

  Map<String, dynamic> toJson() => _$UserParamsToJson(this);
}
