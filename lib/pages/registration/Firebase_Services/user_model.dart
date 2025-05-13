class UserModel {
  String uid;
  String name;
  String email;

  UserModel({required this.uid, required this.name, required this.email});

  // Convert UserModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }

  // Create UserModel from Firestore Document
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
