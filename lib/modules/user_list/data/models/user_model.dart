import 'package:equatable/equatable.dart';
import 'package:fluter_test/modules/user_list/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final int id;
  final String login;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  final String type;
  @JsonKey(name: 'site_admin')
  final bool siteAdmin;

  const UserModel({
    required this.id,
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
    required this.type,
    required this.siteAdmin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  User toEntity() {
    return User(
      id: id,
      login: login,
      avatarUrl: avatarUrl,
      htmlUrl: htmlUrl,
      type: type,
      siteAdmin: siteAdmin,
    );
  }

  @override
  List<Object?> get props => [id, login, avatarUrl, htmlUrl, type, siteAdmin];
}
