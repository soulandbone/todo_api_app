import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_api/services/api_todo.dart';

class AddTodoScreen extends StatefulWidget {
  final Map? todo;

  const AddTodoScreen({this.todo, super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    if (widget.todo != null) {
      isEdit = true;
      setState(() {
        nameController.text = widget.todo!['title'];
        descriptionController.text = widget.todo!['description'];
      });
    }

    super.initState();
  }

  Future<void> updateForm() async {
    final name = nameController.text;
    final description = descriptionController.text;
    final body = {
      "title": name,
      "description": description,
      "is_completed": false
    };
    final id = widget.todo!['_id'];
    final isSuccess = await TodoApi.updateTodo(id, body);

    if (isSuccess) {
      nameController.text = '';
      descriptionController.text = '';
    } else {}
  }

  Future<void> submitForm() async {
    final name = nameController.text;
    final description = descriptionController.text;

    final body = {
      "title": name,
      "description": description,
      "is_completed": false
    };

    final isSuccess = await TodoApi.addTodo(body);

    if (isSuccess) {
      nameController.text = '';
      descriptionController.text = '';
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Todo' : 'Add Todo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          const Gap(15),
          TextField(
            decoration: const InputDecoration(hintText: 'Name'),
            controller: nameController,
          ),
          TextField(
            controller: descriptionController,
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
            decoration: const InputDecoration(
              hintText: 'Description',
            ),
          ),
          const Gap(20),
          ElevatedButton(
              onPressed: isEdit ? updateForm : submitForm,
              child: Text(isEdit ? 'Update' : 'Submit'))
        ],
      ),
    );
  }
}
