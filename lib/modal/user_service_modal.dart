import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_2/modal/user_modal.dart';

class UserService {
  http.Client client;

  UserService({required this.client});

  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<User>> fetchUsers() async {
    final response = await client.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
    final List<dynamic> data = jsonDecode(response.body);
    return data
        .map((json) => User.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
