import 'package:fluter_test/modules/user_list/domain/entities/user.dart';
import 'package:flutter/material.dart';

class UserDetailCard extends StatelessWidget {
  final User user;

  const UserDetailCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
            const SizedBox(height: 20),
            Text(
              user.login,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            _buildDetailRow(Icons.person, user.type),
            const SizedBox(height: 10),
            // _buildDetailRow(
            //   Icons.phone,
            //   'Not available',
            //   showPlaceholder: true,
            // ),
            // const SizedBox(height: 20),
            // ElevatedButton(onPressed: () {}, child: const Text('Contact User')),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String text, {
    bool showPlaceholder = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 10),
        Text(
          showPlaceholder ? 'Phone number not provided' : text,
          style: TextStyle(
            fontSize: 16,
            color: showPlaceholder ? Colors.grey : null,
          ),
        ),
      ],
    );
  }
}
