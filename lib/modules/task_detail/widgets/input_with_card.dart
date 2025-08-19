// lib/shared/widgets/input_with_card.dart
import 'package:flutter/material.dart';

class InputWithCard extends StatelessWidget {
  final String hintText;
  final List<Widget> children;
  final Function(String) onSubmit;

  const InputWithCard({
    super.key,
    required this.hintText,
    required this.onSubmit,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return Column(
      children: [
        Expanded(
          child: children.isEmpty
              ? const Center(child: Text("Chưa có dữ liệu"))
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: children,
                ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        onSubmit(value);
                        textController.clear();
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.green),
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      onSubmit(textController.text);
                      textController.clear();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
