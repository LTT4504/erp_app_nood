import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../lang/app_language_key.dart';
import '../../../shared/constants/colors.dart';
import '../model/leave_model.dart';
import '../my_leave_controller.dart';

class LeaveForm extends StatefulWidget {
  final LeaveModel? leave;
  final int? index;

  const LeaveForm({super.key, this.leave, this.index});

  @override
  State<LeaveForm> createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<LeaveController>();

  String? _typeLeaveKey; // lưu key gốc
  DateTime? _startDate;
  DateTime? _endDate;
  final _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.leave != null) {
      // map từ title đã lưu sang key gốc
      if (widget.leave!.title == AppLanguageKey.annualLeave.tr) {
        _typeLeaveKey = AppLanguageKey.annualLeave;
      } else if (widget.leave!.title == AppLanguageKey.insuranceLeave.tr) {
        _typeLeaveKey = AppLanguageKey.insuranceLeave;
      }
      _reasonController.text = widget.leave!.reason;
      _parseDateRange(widget.leave!.date);
    } else {
      _startDate = DateTime.now();
      _endDate = DateTime.now().add(const Duration(days: 1));
    }
  }

  void _parseDateRange(String dateRange) {
    try {
      final parts = dateRange.split(' - ');
      if (parts.length == 2) {
        _startDate = DateFormat('dd/MM/yyyy HH:mm').parse(parts[0]);
        _endDate = DateFormat('dd/MM/yyyy HH:mm').parse(parts[1]);
      }
    } catch (_) {}
  }

  Future<void> _pickDateTime(bool isStart) async {
    final date = await showDatePicker(
      context: context,
      initialDate: (isStart ? _startDate : _endDate) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: (isStart ? _startDate : _endDate) != null
            ? TimeOfDay.fromDateTime(isStart ? _startDate! : _endDate!)
            : TimeOfDay.now(),
      );
      if (time != null) {
        final dateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
        setState(() {
          if (isStart) {
            _startDate = dateTime;
          } else {
            _endDate = dateTime;
          }
        });
      }
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      if (_startDate == null || _endDate == null) {
        Get.snackbar(
          AppLanguageKey.error.tr,
          AppLanguageKey.pleaseSelectDate.tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      final leave = LeaveModel(
        title: _typeLeaveKey!.tr, // lưu bản dịch
        date:
            '${DateFormat('dd/MM/yyyy HH:mm').format(_startDate!)} - ${DateFormat('dd/MM/yyyy HH:mm').format(_endDate!)}',
        status: AppLanguageKey.newLeave,
        statusColor: Colors.blue.value,
        reason: _reasonController.text,
        days: '${_endDate!.difference(_startDate!).inDays + 1} ${AppLanguageKey.days.tr}',
      );

      if (widget.index != null) {
        controller.updateLeave(widget.index!, leave);
      } else {
        controller.addLeave(leave);
      }
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.highlightPrimary,
        title: Text(widget.leave != null ? AppLanguageKey.editLeave.tr : AppLanguageKey.registerLeave.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: _typeLeaveKey,
                        decoration: InputDecoration(
                          labelText: AppLanguageKey.typeLeave.tr,
                          border: const OutlineInputBorder(),
                        ),
                        items: [
                          AppLanguageKey.annualLeave,
                          AppLanguageKey.insuranceLeave,
                        ].map((key) {
                          return DropdownMenuItem(
                            value: key, // dùng key gốc
                            child: Text(key.tr), // hiển thị bản dịch
                          );
                        }).toList(),
                        onChanged: (value) => setState(() => _typeLeaveKey = value),
                        validator: (value) => value == null ? AppLanguageKey.requiredField.tr : null,
                      ),
                      const SizedBox(height: 16),
                      _dateField(AppLanguageKey.startDate.tr, _startDate, () => _pickDateTime(true)),
                      const SizedBox(height: 16),
                      _dateField(AppLanguageKey.endDate.tr, _endDate, () => _pickDateTime(false)),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _reasonController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: AppLanguageKey.reason.tr,
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty ? AppLanguageKey.requiredField.tr : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.green,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: _saveForm,
              child: Text(AppLanguageKey.save.tr, style: const TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  Widget _dateField(String label, DateTime? date, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        child: Text(
          date != null ? DateFormat('dd/MM/yyyy HH:mm').format(date) : '',
          style: TextStyle(color: date != null ? Colors.black : Colors.grey),
        ),
      ),
    );
  }
}
