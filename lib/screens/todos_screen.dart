import 'package:flutter/material.dart';
import 'package:todo_api/screens/add_todo_screen.dart';
import 'package:todo_api/services/api_todo.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  List<dynamic> todos = [];

  fetchInfo() async {
    final response = await TodoApi.fetchTodos();
    setState(() {
      todos = response;
    });

    print('The list of todos is $todos');
    print('The length of todos is ${todos.length}');
  }

  @override
  void initState() {
    fetchInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Build method is called');
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todos'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          print('Text of index $index is ${todos[index]['title']}');
          return Text(todos[index]['title']);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAdd,
        label: const Text('Add Todo'),
      ),
    );
  }

  void navigateToAdd() {
    final route =
        MaterialPageRoute(builder: (context) => const AddTodoScreen());
    Navigator.push(context, route);
  }
}
