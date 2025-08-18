class BankSalaryModel {
  final int salaryBasic;
  final int salaryGross;
  final String bankName;
  final String bankNumber;
  final String bankAccountName;
  final int paymentType;

  BankSalaryModel({
    required this.salaryBasic,
    required this.salaryGross,
    required this.bankName,
    required this.bankNumber,
    required this.bankAccountName,
    required this.paymentType,
  });

  factory BankSalaryModel.fromJson(Map<String, dynamic> json) {
    return BankSalaryModel(
      salaryBasic: json['salaryBasic'] ?? 0,
      salaryGross: json['salaryGross'] ?? 0,
      bankName: json['bankName'] ?? '',
      bankNumber: json['bankNumber'] ?? '',
      bankAccountName: json['bankAccountName'] ?? '',
      paymentType: json['paymentType'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "bankName": bankName,
      "bankNumber": bankNumber,
      "bankAccountName": bankAccountName,
      "paymentType": paymentType,
    };
  }
}
