
import 'package:flutter/material.dart';

import '../model/user_model.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage:
            NetworkImage('https://via.placeholder.com/150'),
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
    );
  }
}
