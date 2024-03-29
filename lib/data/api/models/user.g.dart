// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as String,
      json['title'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['picture'] as String,
      dateOfBirth: const DateTimeConverter().fromJson(json['dateOfBirth']),
      isSuperLike: json['isSuperLike'] as bool? ?? false,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'picture': instance.picture,
      'dateOfBirth': const DateTimeConverter().toJson(instance.dateOfBirth),
      'isSuperLike': instance.isSuperLike,
    };
