import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUsersEvent extends UserEvent {
  final bool isRefresh;

  const FetchUsersEvent({this.isRefresh = false});

  @override
  List<Object> get props => [isRefresh];
}

class SearchUsersEvent extends UserEvent {
  final String query;

  const SearchUsersEvent(this.query);

  @override
  List<Object> get props => [query];
}

class LoadMoreUsersEvent extends UserEvent {}
