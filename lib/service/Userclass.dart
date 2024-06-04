class UserModel {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? cnic;
  String? phoneNumber;
  String? gender;

  UserModel({
    this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.cnic,
    required this.phoneNumber,
    required this.gender,
  });

  // Create a UserModel from a map
  factory UserModel.fromMap(Map<String, dynamic> userMap) {
    return UserModel(
      userId: userMap['userId'],
      firstName: userMap['firstName'],
      lastName: userMap['lastName'],
      email: userMap['email'],
      cnic: userMap['cnic'],
      phoneNumber: userMap['phoneNumber'],
      gender: userMap['gender'],
    );
  }

  // Convert a UserModel to a map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'cnic': cnic,
      'phoneNumber': phoneNumber,
      'gender': gender,
    };
  }
}


class LawyerModel {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? lNo;
  String? phoneNumber;
  String? gender;

  LawyerModel({
    this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.lNo,
    required this.phoneNumber,
    required this.gender,
  });

  // Create a LawyerModel from a map
  factory LawyerModel.fromMap(Map<String, dynamic> userMap) {
    return LawyerModel(
      userId: userMap['userId'],
      firstName: userMap['firstName'],
      lastName: userMap['lastName'],
      email: userMap['email'],
      lNo: userMap['licenseNumber'],
      phoneNumber: userMap['phoneNumber'],
      gender: userMap['gender'],
    );
  }

  // Convert a LawyerModel to a map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'licenseNumber': lNo,
      'phoneNumber': phoneNumber,
      'gender': gender,
    };
  }
}