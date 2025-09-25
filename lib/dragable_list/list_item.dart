import 'package:flutter/material.dart';
import 'package:three_ui_challenges/dragable_list/reorderable_list_view.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.task, required this.onToggle});

  final Task task;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.drag_handle),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            color: task.isCompleted ? Colors.grey.shade600 : null,
          ),
        ),
        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: (_) => onToggle(),
        ),
        tileColor: Colors.grey.shade200,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      ),
    );
  }
}
