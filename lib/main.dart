import 'package:flutter/material.dart';
import 'package:three_ui_challenges/dragable_list/reorderable_list_view.dart';

void main() {
  runApp(const UiChallenges());
}

class UiChallenges extends StatelessWidget {
  const UiChallenges({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: ReorderableTaskView()),
    );
  }
}
