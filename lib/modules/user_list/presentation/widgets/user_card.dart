import 'package:fluter_test/modules/user_list/domain/entities/user.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  const UserCard({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        splashColor: Colors.blue[200],
        leading: CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl)),
        title: Text(user.login),
        subtitle: Text(user.type),
        onTap: onTap,
      ),
    );
  }
}
