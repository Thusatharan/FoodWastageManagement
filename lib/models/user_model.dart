import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String userName;
  final String roleName;
  final String email;
  final String profileUrl;

  UserModel({
    this.id,
    this.userName,
    this.roleName,
    this.email,
    this.profileUrl,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      id: doc['id'],
      userName: doc['userName'],
      roleName: doc['userRole'],
      email: doc['email'],
      profileUrl: doc['profileUrl'],
    );
  }
}
