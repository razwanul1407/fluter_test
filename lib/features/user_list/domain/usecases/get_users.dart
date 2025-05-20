import 'package:fluter_test/core/usecases/usecase.dart';
import 'package:fluter_test/features/user_list/domain/entities/user.dart';
import 'package:fluter_test/features/user_list/domain/repository/user_repository.dart';

class GetUsers implements UseCase<List<User>, int> {
  final UserRepository repository;

  GetUsers(this.repository);

  @override
  Future<List<User>> call(int page) async {
    return await repository.getUsers(page);
  }
}
