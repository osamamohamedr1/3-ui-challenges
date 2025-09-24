import 'package:flutter/material.dart';

class DragDropScreen extends StatefulWidget {
  const DragDropScreen({super.key});

  @override
  State<DragDropScreen> createState() => _DragDropScreenState();
}

class _DragDropScreenState extends State<DragDropScreen> {
  final List<Color> colors = [Colors.red, Colors.blue, Colors.green];
  final List<bool> matched = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Drag & Drop '),

        actions: [
          IconButton(onPressed: _resetGame, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(colors.length, (index) {
                return _buildDraggableBall(colors[index]);
              }),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(colors.length, (index) {
                return _buildDropTarget(colors[index], index);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDraggableBall(Color color) {
    return Draggable<Color>(
      data: color,
      feedback: _buildBall(color, 45),
      childWhenDragging: _buildBall(Colors.grey.shade300, 40),
      child: _buildBall(color, 50),
    );
  }

  Widget _buildDropTarget(Color targetColor, int index) {
    return DragTarget<Color>(
      onAcceptWithDetails: (details) {
        setState(() {
          if (details.data == targetColor) {
            matched[index] = true;
          }
        });
      },
      builder: (context, candidateData, rejectedData) {
        bool isHovering = candidateData.isNotEmpty;

        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: targetColor.withOpacity(.4),
            borderRadius: BorderRadius.circular(12),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: isHovering ? targetColor : targetColor.withOpacity(0.6),
              width: isHovering ? 4 : 2,
            ),
          ),
          child: matched[index]
              ? const Icon(Icons.check, color: Colors.white, size: 30)
              : null,
        );
      },
    );
  }

  Widget _buildBall(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  void _resetGame() {
    setState(() {
      matched.fillRange(0, matched.length, false);
    });
  }
}
