import 'dart:convert';

import 'package:http/http.dart' as http;

class TodoApi {
  static Future<List<dynamic>> fetchTodos() async {
    var url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);

    print('this is the Json : $json');

    return json['items'];
  }
}
