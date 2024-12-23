import 'package:flutter/material.dart';
import 'package:interview_task/pages/users_screen.dart';
import 'package:provider/provider.dart';

import 'providers/user_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider()..fetchUsers(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UsersScreen(),
    );
  }
}
