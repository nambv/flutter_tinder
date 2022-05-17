// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserParams _$UserParamsFromJson(Map<String, dynamic> json) => UserParams(
      limit: json['limit'] as int? ?? 10,
      page: json['page'] as int? ?? 1,
    );

Map<String, dynamic> _$UserParamsToJson(UserParams instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'page': instance.page,
    };
