import 'dart:convert';

import 'package:http/http.dart' as http;

class TodoApi {
  static Future<List?> fetchTodos() async {
    var url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json['items'];
      return result;
    } else {
      return null;
    }
  }

  static Future<bool> deletebyId(String id) async {
    var url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    return (response.statusCode == 200);
  }

  static Future<void> updateTodo() async {}

  static Future<void> addTodo() async {}
}
