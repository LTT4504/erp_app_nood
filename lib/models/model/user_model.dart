class UserModel {
  final String? fullName;
  final String? nickName;
  final String? phoneNo;
  final String? birthday;
  final int? gender;
  final int? maritalStatus;
  final int? numberChild;
  final String? placeOfBirth;
  final String? address;
  final String? identityCard;
  final String? provideDateIdentityCard;
  final String? providePlaceIdentityCard;

  UserModel({
    this.fullName,
    this.nickName,
    this.phoneNo,
    this.birthday,
    this.gender,
    this.maritalStatus,
    this.numberChild,
    this.placeOfBirth,
    this.address,
    this.identityCard,
    this.provideDateIdentityCard,
    this.providePlaceIdentityCard,
  });

  /// Parse từ API response
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'],
      nickName: json['nickName'],
      phoneNo: json['phoneNo'],
      birthday: json['birthday'],
      gender: json['gender'],
      maritalStatus: json['maritalStatus'],
      numberChild: json['numberChild'],
      placeOfBirth: json['placeOfBirth'],
      address: json['address'],
      identityCard: json['identityCard'],
      provideDateIdentityCard: json['provideDateIdentityCard'],
      providePlaceIdentityCard: json['providePlaceIdentityCard'],
    );
  }

  /// Body gửi khi update
  Map<String, dynamic> toUpdateJson() {
    return {
      "fullName": fullName,
      "nickName": nickName,
      "phoneNo": phoneNo,
      "birthday": birthday,
      "gender": gender,
      "maritalStatus": maritalStatus,
      "numberChild": numberChild,
      "placeOfBirth": placeOfBirth,
      "address": address,
      "identityCard": identityCard,
      "provideDateIdentityCard": provideDateIdentityCard,
      "providePlaceIdentityCard": providePlaceIdentityCard,
    };
  }
}
