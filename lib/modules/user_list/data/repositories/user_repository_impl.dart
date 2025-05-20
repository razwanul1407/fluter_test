import 'package:fluter_test/core/error/exceptions.dart';
import 'package:fluter_test/core/error/failures.dart';
import 'package:fluter_test/core/network/network_info.dart';
import 'package:fluter_test/modules/user_list/data/datasources/user_local_data_source.dart';
import 'package:fluter_test/modules/user_list/data/datasources/user_remote_data_source.dart';
import 'package:fluter_test/modules/user_list/domain/entities/user.dart';
import 'package:fluter_test/modules/user_list/domain/repository/user_repository.dart';
import 'package:flutter/foundation.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<User>> getUsers(int page) async {
    try {
      if (await networkInfo.isConnected) {
        final remoteUsers = await remoteDataSource.getUsers(page);
        await localDataSource.cacheUsers(remoteUsers);
        if (kDebugMode) {
          print(remoteUsers);
        }
        return remoteUsers;
      } else {
        final localUsers = await localDataSource.getCachedUsers();
        return localUsers;
      }
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on CacheException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      throw CacheFailure(e.message);
    }
  }

  @override
  Future<List<User>> searchUsers(String query) async {
    try {
      if (await networkInfo.isConnected) {
        return await remoteDataSource.searchUsers(query);
      } else {
        final localUsers = await localDataSource.getCachedUsers();
        final filteredUsers =
            localUsers.where((user) {
              final fullName = user.login.toLowerCase();
              return fullName.contains(query.toLowerCase());
            }).toList();
        return filteredUsers;
      }
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on CacheException catch (e) {
      throw CacheFailure(e.message);
    }
  }
}
