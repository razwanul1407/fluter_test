import 'package:fluter_test/core/usecases/usecase.dart';
import 'package:fluter_test/features/user_list/domain/entities/user.dart';
import 'package:fluter_test/features/user_list/domain/repository/user_repository.dart';

class SearchUsers implements UseCase<List<User>, String> {
  final UserRepository repository;

  SearchUsers(this.repository);

  @override
  Future<List<User>> call(String query) async {
    return await repository.searchUsers(query);
  }
}
