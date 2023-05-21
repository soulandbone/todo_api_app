import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final String id;
  final int index;
  final String name;
  final String description;
  final Function(String) deleteById;
  final Function navigateToEdit;

  const TodoTile(
      {required this.id,
      required this.index,
      required this.name,
      required this.description,
      required this.deleteById,
      required this.navigateToEdit,
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
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 'delete') {
              deleteById(id);
            } else if (value == 'edit') {
              navigateToEdit();
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Text('Edit'),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
