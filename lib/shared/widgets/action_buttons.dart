import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const ActionButtons({
    super.key,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onCancel,
            icon: const Icon(Icons.close),
            label: const Text("Cancel"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: ColorConstants.highlightPrimary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  color: ColorConstants.highlightPrimary,
                  width: 1.2,
                ),
              ),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onSave,
            icon: const Icon(Icons.save),
            label: const Text("Save"),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.highlightPrimary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
          ),
        ),
      ],
    );
  }
}
