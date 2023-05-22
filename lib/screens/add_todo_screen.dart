import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

class AddTodoScreen extends StatefulWidget {
  final bool isEdit;
  final Map? todo;

  const AddTodoScreen({this.isEdit = false, this.todo, super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    if (widget.todo != null) {
      print('widget.todo is ${widget.todo}');
      setState(() {
        nameController.text = widget.todo!['title'];
        descriptionController.text = widget.todo!['description'];
      });
    }

    super.initState();
  }

  Future<void> submitForm() async {
    final name = nameController.text;
    final description = descriptionController.text;
    final body = {
      "title": name,
      "description": description,
      "is_completed": false
    };

    if (widget.isEdit) {
      final id = widget.todo!['_id'];
      print(widget.todo!['_id']);
      var url = 'https://api.nstack.in/v1/todos/$id';
      final uri = Uri.parse(url);
      final response = await http.put(uri,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 201) {
        nameController.text = '';
        descriptionController.text = '';
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } else {
      var url = 'https://api.nstack.in/v1/todos/';
      final uri = Uri.parse(url);
      final response = await http.post(uri,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 201) {
        nameController.text = '';
        descriptionController.text = '';
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isEdit ? const Text('Edit Todo') : const Text('Add Todo'),
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
              onPressed: submitForm,
              child: widget.isEdit
                  ? const Text("Edit Task")
                  : const Text('Submit'))
        ],
      ),
    );
  }
}
