import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tinder/data/api/converter/date_time_converter.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends ChangeNotifier {
  User(
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.picture, {
    this.dateOfBirth,
    this.isSuperLike = false,
  });

  String id;
  String title;
  String firstName;
  String lastName;
  String picture;

  @DateTimeConverter()
  DateTime? dateOfBirth;

  bool isSuperLike; // mark super like

  setDateOfBirth(DateTime? value) {
    dateOfBirth = value;
    notifyListeners();
  }

  int get age {
    if (null == dateOfBirth) return 0;

    DateTime today = DateTime.now();
    return today.year - dateOfBirth!.year;
  }

  String get fullName => "$firstName $lastName";

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
