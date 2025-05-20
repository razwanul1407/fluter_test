import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fluter_test/features/user_list/domain/usecases/get_users.dart';
import 'package:fluter_test/features/user_list/domain/usecases/search_users.dart';
import 'package:fluter_test/features/user_list/presentation/bloc/user_event.dart';
import 'package:fluter_test/features/user_list/presentation/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsers getUsers;
  final SearchUsers searchUsers;

  int currentPage = 1;
  bool hasReachedMax = false;
  String currentQuery = '';

  UserBloc({required this.getUsers, required this.searchUsers})
    : super(UserEmpty()) {
    on<FetchUsersEvent>(_onFetchUsers);
    on<SearchUsersEvent>(_onSearchUsers);
    on<LoadMoreUsersEvent>(_onLoadMoreUsers);
  }

  Future<void> _onFetchUsers(
    FetchUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    if (event.isRefresh) {
      currentPage = 1;
      hasReachedMax = false;
      currentQuery = '';
    }

    if (state is UserLoaded && !event.isRefresh) return;

    try {
      emit(UserLoading());
      final users = await getUsers(currentPage);

      emit(UserLoaded(users: users, hasReachedMax: users.isEmpty));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onSearchUsers(
    SearchUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    if (event.query.isEmpty) {
      add(const FetchUsersEvent(isRefresh: true));
      return;
    }

    currentQuery = event.query;
    currentPage = 1;
    hasReachedMax = false;

    try {
      emit(UserLoading());
      final users = await searchUsers(event.query);

      emit(UserLoaded(users: users, hasReachedMax: true, isSearching: true));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onLoadMoreUsers(
    LoadMoreUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    if (hasReachedMax || state is! UserLoaded) return;

    final currentState = state as UserLoaded;
    if (currentState.isSearching) return;

    try {
      currentPage++;
      final users = await getUsers(currentPage);

      emit(
        currentState.copyWith(
          users: [...currentState.users, ...users],
          hasReachedMax: users.isEmpty,
        ),
      );
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
