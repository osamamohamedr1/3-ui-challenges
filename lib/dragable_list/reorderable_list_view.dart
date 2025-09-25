import 'package:flutter/material.dart';
import 'package:three_ui_challenges/dragable_list/list_item.dart';

class Task {
  final String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});
}

class ReorderableTaskView extends StatefulWidget {
  const ReorderableTaskView({super.key});

  @override
  State<ReorderableTaskView> createState() => _ReorderableTaskViewState();
}

class _ReorderableTaskViewState extends State<ReorderableTaskView> {
  List<Task> tasks = [
    Task(title: 'Clean Architecture'),
    Task(title: 'Flutter UI'),
    Task(title: 'Widget catalog'),
  ];

  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reorderable Tasks')),
      body: ReorderableListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(tasks[index].title),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.red,
              child: const Icon(Icons.delete, color: Colors.white, size: 30),
            ),
            onDismissed: (direction) {
              final deletedTask = tasks[index];
              final deletedIndex = index;
              _deleteTask(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${deletedTask.title} deleted'),
                  duration: const Duration(seconds: 4),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      setState(() {
                        tasks.insert(deletedIndex, deletedTask);
                      });
                    },
                  ),
                ),
              );
            },
            child: ListItem(
              key: ValueKey('${tasks[index].title}_item'),
              task: tasks[index],
              onToggle: () => _toggleTaskCompletion(index),
            ),
          );
        },
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) newIndex -= 1;
            final item = tasks.removeAt(oldIndex);
            tasks.insert(newIndex, item);
          });
        },
      ),
    );
  }
}
