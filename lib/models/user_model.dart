import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String userName;
  final String roleName;
  final String email;
  final String profileUrl;

  User({
    this.id,
    this.userName,
    this.roleName,
    this.email,
    this.profileUrl,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      userName: doc['userName'],
      roleName: doc['roleName'],
      email: doc['email'],
      profileUrl: doc['profileUrl'],
    );
  }
}
