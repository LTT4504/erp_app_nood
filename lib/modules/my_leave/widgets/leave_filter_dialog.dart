import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../lang/app_language_key.dart';
import '../my_leave_controller.dart';
import '../../../shared/widgets/date_range_picker.dart';

class LeaveFilterDialog extends StatefulWidget {
  final LeaveController controller;

  const LeaveFilterDialog({super.key, required this.controller});

  @override
  State<LeaveFilterDialog> createState() => _LeaveFilterDialogState();
}

class _LeaveFilterDialogState extends State<LeaveFilterDialog> {
  String selectedType = AppLanguageKey.all.tr;
  String selectedStatus = AppLanguageKey.all.tr;
  DateTime? fromDate;
  DateTime? toDate;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // AppBar trong Filter
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            child: Text(
              AppLanguageKey.filter.tr,
              style: const TextStyle(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // Nội dung
          Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSelectField(
                    label: AppLanguageKey.typeLeaveFilter.tr,
                    value: selectedType,
                    options: [
                      "All",
                      ...widget.controller.leaveRequests
                          .map((e) => e.title.tr)
                          .toSet()
                          .toList()
                    ],
                    onSelected: (val) => setState(() => selectedType = val),
                  ),
                  const SizedBox(height: 8),

                  _buildSelectField(
                    label: AppLanguageKey.status.tr,
                    value: selectedStatus,
                    options: [
                      ...[
                        AppLanguageKey.newLeave,
                        AppLanguageKey.waiting,
                        AppLanguageKey.approved,
                        AppLanguageKey.refuse,
                        AppLanguageKey.cancel
                      ].map((e) => e.tr)
                    ],
                    onSelected: (val) => setState(() => selectedStatus = val),
                  ),
                  const SizedBox(height: 8),

                  _buildDateField(
                    label: AppLanguageKey.fromDate.tr,
                    date: fromDate,
                    onPicked: (d) => setState(() => fromDate = d),
                  ),
                  const SizedBox(height: 8),

                  _buildDateField(
                    label: AppLanguageKey.toDate.tr,
                    date: toDate,
                    onPicked: (d) => setState(() => toDate = d),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.pop(context, null),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.green,
                          side: const BorderSide(color: Colors.green),
                        ),
                        child: Text(AppLanguageKey.cancel.tr),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, {
                            "type": selectedType,
                            "status": selectedStatus,
                            "from": fromDate,
                            "to": toDate,
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: Text(AppLanguageKey.apply.tr,
                            style: const TextStyle(color: Colors.white)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectField({
    required String label,
    required String value,
    required List<String> options,
    required ValueChanged<String> onSelected,
  }) {
    return InkWell(
      onTap: () async {
        final result = await _showCustomSelectDialog(
          title: label,
          options: options,
          initial: value,
        );
        if (result != null) onSelected(result);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        child: Text(value),
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? date,
    required ValueChanged<DateTime> onPicked,
  }) {
    return InkWell(
      onTap: () async {
        final picked = await defaultShowDatePicker(context, date);
        if (picked != null) onPicked(picked);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        child: Text(
          date != null
              ? "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}"
              : "dd/mm/yyyy",
          style: TextStyle(
            color: date != null ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }

  Future<String?> _showCustomSelectDialog({
    required String title,
    required List<String> options,
    String initial = "All",
  }) async {
    String selected = initial;

    return showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Mini AppBar cho Type/Status
              Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildSelectableItem(
                          label: AppLanguageKey.all.tr,
                          isSelected: selected == AppLanguageKey.all.tr,
                          onTap: () => setState(() => selected = AppLanguageKey.all.tr),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(AppLanguageKey.options.tr,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(height: 8),
                        ...options
                            .where((opt) => opt != "All")
                            .map((opt) => _buildSelectableItem(
                                  label: opt,
                                  isSelected: selected == opt,
                                  onTap: () =>
                                      setState(() => selected = opt),
                                )),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () => Navigator.pop(context, null),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.green,
                                side: const BorderSide(color: Colors.green),
                              ),
                              child: Text(AppLanguageKey.cancel.tr),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () =>
                                  Navigator.pop(context, selected),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: const Text("OK",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildSelectableItem({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green),
        ),
        child: Row(
          children: [
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green, width: 2),
                color: isSelected ? Colors.green : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
