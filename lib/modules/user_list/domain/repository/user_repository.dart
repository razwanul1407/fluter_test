import 'package:fluter_test/modules/user_list/domain/entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers(int page);
  Future<List<User>> searchUsers(String query);
}
