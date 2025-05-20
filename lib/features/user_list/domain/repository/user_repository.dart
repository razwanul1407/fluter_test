import 'package:fluter_test/features/user_list/domain/entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers(int page);
  Future<List<User>> searchUsers(String query);
}
