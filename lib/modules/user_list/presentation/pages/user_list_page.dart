import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_detail_page.dart';
import 'package:fluter_test/modules/user_list/presentation/bloc/user_bloc.dart';
import 'package:fluter_test/modules/user_list/presentation/bloc/user_event.dart';
import 'package:fluter_test/modules/user_list/presentation/bloc/user_state.dart';
import 'package:fluter_test/modules/user_list/presentation/widgets/error_widget.dart';
import 'package:fluter_test/modules/user_list/presentation/widgets/loading_widget.dart';
import 'package:fluter_test/modules/user_list/presentation/widgets/user_card.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<UserBloc>().add(const FetchUsersEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<UserBloc>().add(LoadMoreUsersEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<UserBloc>().add(
                      const FetchUsersEvent(isRefresh: true),
                    );
                  },
                ),
              ),
              onChanged: (query) {
                context.read<UserBloc>().add(SearchUsersEvent(query));
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _searchController.clear();
                context.read<UserBloc>().add(
                  const FetchUsersEvent(isRefresh: true),
                );
              },
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserEmpty) {
                    return const Center(child: Text('No users available'));
                  } else if (state is UserLoading) {
                    return const LoadingWidget();
                  } else if (state is UserError) {
                    return CustomErrorWidget(
                      message: state.message,
                      onRetry: () {
                        context.read<UserBloc>().add(const FetchUsersEvent());
                      },
                    );
                  } else if (state is UserLoaded) {
                    if (state.users.isEmpty) {
                      return const Center(child: Text('No users found'));
                    }
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount:
                          state.hasReachedMax
                              ? state.users.length
                              : state.users.length + 1,
                      itemBuilder: (context, index) {
                        if (index >= state.users.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        final user = state.users[index];
                        return UserCard(
                          user: user,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => UserDetailPage(user: user),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
