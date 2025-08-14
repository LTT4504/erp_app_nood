import 'package:flutter/material.dart';
import '../../../lang/app_language_key.dart';
import 'package:get/get.dart';

class SearchBarWithFilter extends StatelessWidget {
  final VoidCallback onFilterTap;
  const SearchBarWithFilter({super.key, required this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: TextField(
          decoration: InputDecoration(
            hintText: AppLanguageKey.search.tr,
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
      const SizedBox(width: 8),
      GestureDetector(
        onTap: onFilterTap,
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.format_list_bulleted),
        ),
      ),
    ]);
  }
}
