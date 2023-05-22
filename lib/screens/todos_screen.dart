import 'package:flutter/material.dart';
import 'package:todo_api/helpers/snackbar_helper.dart';
import 'package:todo_api/screens/add_todo_screen.dart';
import 'package:todo_api/services/api_todo.dart';
import 'package:todo_api/widgets/todo_tile.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  List<dynamic> todos = [];

  Future<void> fetchInfo() async {
    final response = await TodoApi.fetchTodos();
    setState(() {
      todos = response;
    });
  }

  Future<void> deleteByID(String id) async {
    final isSuccess = await TodoApi.deletebyId(id);

    if (isSuccess) {
      setState(() {
        todos.removeWhere((element) => element['_id'] == id);
        showSnackbarMessage(context,
            message: 'The entry has been deleted succesfully');
      });
    } else {}
  }

  Future<void> onRefresh() async {
    setState(() {
      fetchInfo();
    });
  }

  void navigateToAdd() {
    final route =
        MaterialPageRoute(builder: (context) => const AddTodoScreen());
    Navigator.push(context, route);
  }

  void navigateToEdit(String id) {
    final map = todos.firstWhere((element) => id == element['_id']);
    final route = MaterialPageRoute(
        builder: (context) => AddTodoScreen(
              todo: map,
              isEdit: true,
            ));
    Navigator.push(context, route);
  }

  @override
  void initState() {
    fetchInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print('Build method is called');
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Todos'),
        ),
        body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            //print('Text of index $index is ${todos[index]['title']}');
            return TodoTile(
              deleteById: deleteByID,
              navigateToEdit: navigateToEdit,
              id: todos[index]['_id'],
              index: (index + 1),
              name: todos[index]['title'],
              description: todos[index]['description'],
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateToAdd,
          label: const Text('Add Todo'),
        ),
      ),
    );
  }
}
