import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String login;
  final String avatarUrl;
  final String htmlUrl;
  final String type;
  final bool siteAdmin;

  const User({
    required this.id,
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
    required this.type,
    required this.siteAdmin,
  });

  @override
  List<Object?> get props => [id, login, avatarUrl, htmlUrl, type, siteAdmin];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'avatar_url': avatarUrl,
      'html_url': htmlUrl,
      'type': type,
      'site_admin': siteAdmin,
    };
  }
}
