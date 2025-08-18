class EducationModel {
  final String education;
  final String businessExperience;
  final String softSkills;
  final String englishLevel;
  final String japaneseLevel;

  EducationModel({
    required this.education,
    required this.businessExperience,
    required this.softSkills,
    required this.englishLevel,
    required this.japaneseLevel,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      education: json['education'] ?? '',
      businessExperience: json['businessExperience'] ?? '',
      softSkills: json['softSkills'] ?? '',
      englishLevel: json['englishLevel'] ?? '',
      japaneseLevel: json['japaneseLevel'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "education": education,
      "businessExperience": businessExperience,
      "softSkills": softSkills,
      "englishLevel": englishLevel,
      "japaneseLevel": japaneseLevel,
    };
  }
}
