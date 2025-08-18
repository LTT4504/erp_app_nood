class EmergencyContact {
  String namePrimaryContact;
  String relationshipPrimaryContact;
  String phoneNoPrimaryContact;
  String nameSecondaryContact;
  String relationshipSecondaryContact;
  String phoneNoSecondaryContact;

  EmergencyContact({
    required this.namePrimaryContact,
    required this.relationshipPrimaryContact,
    required this.phoneNoPrimaryContact,
    required this.nameSecondaryContact,
    required this.relationshipSecondaryContact,
    required this.phoneNoSecondaryContact,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      namePrimaryContact: json['namePrimaryContact'] ?? '',
      relationshipPrimaryContact: json['relationshipPrimaryContact'] ?? '',
      phoneNoPrimaryContact: json['phoneNoPrimaryContact'] ?? '',
      nameSecondaryContact: json['nameSecondaryContact'] ?? '',
      relationshipSecondaryContact: json['relationshipSecondaryContact'] ?? '',
      phoneNoSecondaryContact: json['phoneNoSecondaryContact'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'namePrimaryContact': namePrimaryContact,
      'relationshipPrimaryContact': relationshipPrimaryContact,
      'phoneNoPrimaryContact': phoneNoPrimaryContact,
      'nameSecondaryContact': nameSecondaryContact,
      'relationshipSecondaryContact': relationshipSecondaryContact,
      'phoneNoSecondaryContact': phoneNoSecondaryContact,
    };
  }
}
