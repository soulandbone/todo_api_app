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
    if (response != null) {
      setState(() {
        todos = response;
      });
    } else {
      if (context.mounted) {
        showSnackbarMessage(context,
            message: 'There was an error retrieving the tasks');
      }
    }
  }

  Future<void> deleteByID(String id) async {
    final isSuccess = await TodoApi.deletebyId(id);

    if (isSuccess) {
      setState(() {
        todos.removeWhere((element) => element['_id'] == id);
        showSnackbarMessage(context,
            message: 'The entry has been deleted succesfully');
      });
    } else {
      if (context.mounted) {
        showSnackbarMessage(context, message: 'The deletion has failed');
      }
    }
  }

  Future<void> navigateToAdd() async {
    final route =
        MaterialPageRoute(builder: (context) => const AddTodoScreen());
    await Navigator.push(context, route);
    setState(() {
      fetchInfo();
    });
  }

  Future<void> navigateToEdit(String id) async {
    final map = todos.firstWhere((element) => id == element['_id']);
    final route = MaterialPageRoute(
        builder: (context) => AddTodoScreen(
              todo: map,
            ));
    await Navigator.push(context, route);
    setState(() {
      fetchInfo();
    });
  }

  @override
  void initState() {
    fetchInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print('Build method is called');
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todos'),
      ),
      body: RefreshIndicator(
        onRefresh: fetchInfo,
        child: todos.isEmpty
            ? const Center(child: Text('its empty'))
            : ListView.builder(
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAdd,
        label: const Text('Add Todo'),
      ),
    );
  }
}
