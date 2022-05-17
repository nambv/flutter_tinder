import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User(
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.picture,
  );

  String id;
  String title;
  String firstName;
  String lastName;
  String picture;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
