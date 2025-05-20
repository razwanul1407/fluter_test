import 'dart:convert';
import 'package:fluter_test/core/constants/app_constants.dart';
import 'package:fluter_test/core/error/exceptions.dart';
import 'package:fluter_test/features/user_list/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  Future<void> cacheUsers(List<User> users);
  Future<List<User>> getCachedUsers();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheUsers(List<User> users) async {
    try {
      // final userStrings = users.map((user) => user.toJson()).toList();

      final userStrings =
          users
              .map(
                (user) => jsonEncode({
                  'id': user.id,
                  'login': user.login,
                  'avatar_url': user.avatarUrl,
                  'html_url': user.htmlUrl,
                  'type': user.type,
                  'site_admin': user.siteAdmin,
                }),
              )
              .toList();

      await sharedPreferences.setStringList(
        AppConstants.usersCacheKey,
        userStrings.cast<String>(),
      );
    } catch (e) {
      throw CacheException('Failed to cache users');
    }
  }

  // @override
  // Future<List<User>> getCachedUsers() async {
  //   try {
  //     final userStrings =
  //         sharedPreferences.getStringList(AppConstants.usersCacheKey) ?? [];
  //     return userStrings
  //         .map((userString) => User.fromJson(userString))
  //         .toList();
  //   } catch (e) {
  //     throw CacheException('Failed to get cached users');
  //   }
  // }
  @override
  Future<List<User>> getCachedUsers() async {
    try {
      final userStrings =
          sharedPreferences.getStringList(AppConstants.usersCacheKey) ?? [];
      return userStrings.map((userString) {
        final map = jsonDecode(userString);
        return User(
          id: map['id'],
          login: map['login'],
          avatarUrl: map['avatar_url'],
          htmlUrl: map['html_url'],
          type: map['type'],
          siteAdmin: map['site_admin'],
        );
      }).toList();
    } catch (e) {
      throw CacheException('Failed to get cached users');
    }
  }
}
