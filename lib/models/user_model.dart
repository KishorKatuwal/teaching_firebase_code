class UserModel {
  final String name;
  final String uid;
  final String phoneNumber;
  final String email;
  final String password;

  UserModel({
    required this.email,
    required this.password,
    required this.name,
    required this.uid,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'uid': uid,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'] ?? '',
        uid: map['uid'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        email: map['email'] ?? '',
        password: map['password'] ?? '');
  }
}
