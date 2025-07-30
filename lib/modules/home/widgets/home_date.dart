import 'package:flutter/material.dart';

class HomeDate extends StatelessWidget {
  const HomeDate({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Thứ Tư, 30/07/2025",
      style: TextStyle(
        color: Colors.green,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
