import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../shared/widgets/date_range_picker.dart';

class FilterBottomSheet {
  static final box = GetStorage();

  static void show(BuildContext context) {
    // Lấy giá trị từ local
    String type = box.read("filter_type") ?? "All";
    String status = box.read("filter_status") ?? "All";
    DateTime? fromDate =
        _parseDate(box.read("filter_fromDate")); // parse String -> DateTime
    DateTime? toDate = _parseDate(box.read("filter_toDate"));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Filter",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Get.back(),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 🔹 Type project
                  const Text("Type project"),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    decoration: _inputDecoration(),
                    value: type,
                    items: const [
                      DropdownMenuItem(value: "All", child: Text("All")),
                      DropdownMenuItem(value: "Internal", child: Text("Internal")),
                      DropdownMenuItem(value: "Product", child: Text("Product")),
                    ],
                    onChanged: (val) {
                      setState(() => type = val!);
                      box.write("filter_type", val);
                    },
                  ),
                  const SizedBox(height: 16),

                  // 🔹 Status
                  const Text("Status"),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    decoration: _inputDecoration(),
                    value: status,
                    items: const [
                      DropdownMenuItem(value: "All", child: Text("All")),
                      DropdownMenuItem(value: "New", child: Text("New")),
                      DropdownMenuItem(
                          value: "In Progress", child: Text("In Progress")),
                      DropdownMenuItem(value: "Done", child: Text("Done")),
                    ],
                    onChanged: (val) {
                      setState(() => status = val!);
                      box.write("filter_status", val);
                    },
                  ),
                  const SizedBox(height: 16),

                  // 🔹 DateRangePicker thay cho From date + To date
                  DateRangePicker(
                    fromDate: fromDate,
                    toDate: toDate,
                    onShowPicker: (ctx, initialDate) async {
                      return await defaultShowDatePicker(ctx, initialDate);
                    },
                    onPickDate: (isFrom, picked) {
                      setState(() {
                        if (isFrom) {
                          fromDate = picked;
                          box.write("filter_fromDate",
                              "${picked.day}/${picked.month}/${picked.year}");
                        } else {
                          toDate = picked;
                          box.write("filter_toDate",
                              "${picked.day}/${picked.month}/${picked.year}");
                        }
                      });
                    },
                  ),

                  const SizedBox(height: 24),

                  // 🔹 Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            // Clear local
                            box.remove("filter_type");
                            box.remove("filter_status");
                            box.remove("filter_fromDate");
                            box.remove("filter_toDate");
                            Get.back();
                          },
                          child: const Text("Clear"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            // Apply filter (giữ trong local)
                            Get.back();
                          },
                          child: const Text("Apply"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static InputDecoration _inputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }

  /// Helper để parse string "dd/MM/yyyy" -> DateTime
  static DateTime? _parseDate(String? dateStr) {
    if (dateStr == null) return null;
    try {
      final parts = dateStr.split("/");
      if (parts.length == 3) {
        return DateTime(
          int.parse(parts[2]),
          int.parse(parts[1]),
          int.parse(parts[0]),
        );
      }
    } catch (_) {}
    return null;
  }
}
