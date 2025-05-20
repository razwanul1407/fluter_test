import 'package:dio/dio.dart';
import 'package:fluter_test/core/error/exceptions.dart';
import 'package:fluter_test/core/network/api_client.dart';
import 'package:fluter_test/modules/user_list/data/models/user_model.dart';
import 'package:fluter_test/modules/user_list/domain/entities/user.dart';

abstract class UserRemoteDataSource {
  Future<List<User>> getUsers(int page);
  Future<List<User>> searchUsers(String query);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient apiClient;

  UserRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<User>> getUsers(int page) async {
    try {
      final response = await apiClient.get(
        '/users',
        queryParameters: {
          'since':
              (page - 1) * 10, // GitHub uses 'since' parameter for pagination
          'per_page': 10,
        },
      );

      final users =
          (response.data as List)
              .map((userJson) => UserModel.fromJson(userJson).toEntity())
              .toList();

      return users;
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch users');
    }
  }

  @override
  Future<List<User>> searchUsers(String query) async {
    try {
      final response = await apiClient.get(
        '/search/users',
        queryParameters: {'q': query},
      );

      final users =
          (response.data['items'] as List)
              .map((userJson) => UserModel.fromJson(userJson).toEntity())
              .toList();

      return users;
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to search users');
    }
  }
}
