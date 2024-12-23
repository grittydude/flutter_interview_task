import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../providers/user_provider.dart';
import '../widgets/user_tile.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search users...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (query) => userProvider.searchUsers(query),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => userProvider.fetchUsers(),
        child: _buildUserList(userProvider),
      ),
    );
  }

  Widget _buildUserList(UserProvider userProvider) {
    switch (userProvider.state) {
      case UserState.loading:
        return const Center(child: CircularProgressIndicator());
      case UserState.error:
        return _buildErrorState(userProvider);

      case UserState.data:
        return ListView.builder(
          itemCount: userProvider.users.length,
          itemBuilder: (context, index) {
            final User user = userProvider.users[index];
            return UserTile(user: user);
          },
        );
    }
  }

  Widget _buildErrorState(UserProvider userProvider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error: ${userProvider.errorMessage}',
              style: const TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => userProvider.fetchUsers(),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
