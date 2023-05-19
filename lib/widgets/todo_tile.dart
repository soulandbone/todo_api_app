import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final int index;
  final String name;
  final String description;

  const TodoTile(
      {required this.index,
      required this.name,
      required this.description,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          child: Text(index.toString()),
        ),
        title: Text(name),
        subtitle: Text(description),
      ),
    );
  }
}
