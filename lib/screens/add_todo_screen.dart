import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Todo'),
      ),
      body: ListView(
        children: [
          const Gap(15),
          TextField(
            decoration: const InputDecoration(hintText: 'Name'),
            controller: name,
          ),
          TextField(
            controller: description,
            minLines: 5,
            maxLines: 8,
            decoration: const InputDecoration(
              hintText: 'Description',
            ),
          )
        ],
      ),
    );
  }
}
