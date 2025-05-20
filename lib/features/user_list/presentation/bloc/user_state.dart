import 'package:equatable/equatable.dart';
import 'package:fluter_test/features/user_list/domain/entities/user.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserEmpty extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  final bool hasReachedMax;
  final bool isSearching;

  const UserLoaded({
    required this.users,
    this.hasReachedMax = false,
    this.isSearching = false,
  });

  UserLoaded copyWith({
    List<User>? users,
    bool? hasReachedMax,
    bool? isSearching,
  }) {
    return UserLoaded(
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  List<Object> get props => [users, hasReachedMax, isSearching];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object> get props => [message];
}
