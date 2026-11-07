// lib/main.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String city; // extracted from nested address.city

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.city,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      city: (json['address']?['city'] as String?) ?? 'Unknown',
    );
  }

  @override
  String toString() => 'User(id: $id, name: $name, email: $email)';
}

// ─────────────────────────────────────────────────────────────
// 2. API SERVICE
// ─────────────────────────────────────────────────────────────
class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('$_baseUrl/users'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load users (HTTP ${response.statusCode})');
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

// ─────────────────────────────────────────────────────────────
// 3. USER TILE (extracted for widget-testability)
// ─────────────────────────────────────────────────────────────
class UserTile extends StatelessWidget {
  final User user;

  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text('${user.id}')),
      title: Text(user.name),
      subtitle: Text('${user.email} • ${user.city}'),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// 4. SCREEN (FutureBuilder + late Future)
// ─────────────────────────────────────────────────────────────
class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ApiService _api = ApiService();

  // The one-time "handle" to the pending request.
  late Future<List<User>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = _api.fetchUsers(); // created ONCE
  }

  void _reload() {
    setState(() {
      _usersFuture = _api.fetchUsers(); // new future → FutureBuilder restarts
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            onPressed: _reload,
            icon: const Icon(Icons.refresh),
            tooltip: 'Reload',
          ),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: _usersFuture, // SAME future across rebuilds
        builder: (context, snapshot) {
          // 1. Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Error
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Something went wrong:\n${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _reload,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          // 3. Empty
          final users = snapshot.data ?? [];
          if (users.isEmpty) {
            return const Center(child: Text('No users found.'));
          }

          // 4. Data
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index]; // index-wise access
              return UserTile(user: user);
            },
          );
        },
      ),
    );
  }
}

