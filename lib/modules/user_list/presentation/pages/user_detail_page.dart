import 'package:fluter_test/modules/user_list/domain/entities/user.dart';
import 'package:fluter_test/modules/user_list/presentation/widgets/user_detail_card.dart';
import 'package:flutter/material.dart';

class UserDetailPage extends StatelessWidget {
  final User user;

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.login), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: UserDetailCard(user: user),
      ),
    );
  }
}
