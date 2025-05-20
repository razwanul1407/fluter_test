// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: (json['id'] as num).toInt(),
  login: json['login'] as String,
  avatarUrl: json['avatar_url'] as String,
  htmlUrl: json['html_url'] as String,
  type: json['type'] as String,
  siteAdmin: json['site_admin'] as bool,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'login': instance.login,
  'avatar_url': instance.avatarUrl,
  'html_url': instance.htmlUrl,
  'type': instance.type,
  'site_admin': instance.siteAdmin,
};
