import 'package:flutter/material.dart';
import 'package:todo_api/screens/add_todo_screen.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todos'),
      ),
      body: ListView(
        children: const [
          Center(
            child: Text('One Todo'),
          )
        ],
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
