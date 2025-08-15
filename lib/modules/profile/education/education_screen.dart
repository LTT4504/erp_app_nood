import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:work_manager/shared/constants/colors.dart';
import '../../../shared/widgets/custom_text_form_field.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  bool isEditing = false;

  final box = GetStorage();

  final educationInfoController = TextEditingController();
  final softSkillsController = TextEditingController();
  final businessExpController = TextEditingController();
  final englishController = TextEditingController();
  final japaneseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    educationInfoController.text = box.read("educationInfo") ?? "Dai hoc VKUAAA";
    softSkillsController.text = box.read("softSkills") ?? "KNM";
    businessExpController.text = box.read("businessExp") ?? "Dài Dài";
    englishController.text = box.read("english") ?? "9.0";
    japaneseController.text = box.read("japanese") ?? "5.2";
  }

  void _saveData() {
    box.write("educationInfo", educationInfoController.text);
    box.write("softSkills", softSkillsController.text);
    box.write("businessExp", businessExpController.text);
    box.write("english", englishController.text);
    box.write("japanese", japaneseController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.highlightPrimaryPastel,
      appBar: AppBar(
        foregroundColor: ColorConstants.white,
        title: const Text("Education",style: TextStyle(color: ColorConstants.white),),
        backgroundColor: ColorConstants.highlightPrimary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabeledCard(
              label: "Education",
              children: [
                _buildCustomField("Education Information", "Enter education info", Icons.school, educationInfoController),
                _buildCustomField("Soft Skills", "Enter soft skills", Icons.lightbulb, softSkillsController),
                _buildCustomField("Business Experience", "Enter business experience", Icons.work, businessExpController),
              ],
            ),
            const SizedBox(height: 24),
            _buildLabeledCard(
              label: "Foreign Languages",
              children: [
                _buildCustomField("English", "Enter English level", Icons.language, englishController),
                _buildCustomField("Japanese", "Enter Japanese level", Icons.translate, japaneseController),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.highlightPrimary,
        child: Icon(isEditing ? Icons.save : Icons.edit, color: ColorConstants.white,),
        onPressed: () {
          setState(() {
            if (isEditing) {
              // Lưu dữ liệu và khóa
              FocusScope.of(context).unfocus();
              _saveData();
            }
            isEditing = !isEditing;
          });
        },
      ),
    );
  }

  Widget _buildLabeledCard({required String label, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ColorConstants.highlightPrimary),
        ),
        const SizedBox(height: 8),
        Card(
          color: ColorConstants.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: children
                  .map((child) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: child,
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomField(String label, String hint, IconData icon, TextEditingController controller) {
    return CustomTextFormField(
      label: label,
      hint: hint,
      icon: icon,
      primaryColor: Colors.green,
      controller: controller,
      readOnly: !isEditing,
    );
  }
}
