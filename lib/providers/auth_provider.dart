import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_wastage_management/screens/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class Authentication extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _timestamp = DateTime.now();

  // FirebaseAuth Sign In
  Future<User> emailSignIn({
    String email,
    String password,
  }) async {
    UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    User _user = _userCredential.user;
    notifyListeners();

    return _user;
  }

  // FirebaseAuth Sign Up
  Future<User> emailSignUp({
    String userName,
    String userRole,
    String email,
    String password,
  }) async {
    UserCredential _userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User _user = _userCredential.user;

    if (_user != null) {
      await userRef.doc(_user.uid).set({
        'id': _user.uid,
        'userName': userName,
        'userRole': userRole,
        'userEmail': email,
        'userProfileUrl':
            'https://ui-avatars.com/api/?name=$userName&background=FF5500&color=fff&length=1%27',
        'userCreatedAt': DateFormat('dd/MM/yyyy hh:mm').format(_timestamp),
      });
    }

    notifyListeners();

    return _user;
  }

  // Forgot Password
  Future<void> forgotPassword({String email}) async {
    await _auth.sendPasswordResetEmail(
      email: email,
    );

    notifyListeners();
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();

    notifyListeners();
  }

  /* ******************************************************* */

  // Sign In With Google
  Future<User> googleSignIn({String roleName}) async {
    final GoogleSignInAccount _googleSignInAccount =
        await _googleSignIn.signIn();

    final GoogleSignInAuthentication _googleSignInAuthentication =
        await _googleSignInAccount.authentication;

    final AuthCredential _authCredential = GoogleAuthProvider.credential(
      idToken: _googleSignInAuthentication.idToken,
      accessToken: _googleSignInAuthentication.accessToken,
    );

    UserCredential _userCredential =
        await _auth.signInWithCredential(_authCredential);

    final User _googleUser = _userCredential.user;

    if (_googleUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_googleUser.uid)
          .set({
        'id': _googleUser.uid,
        'userName': _googleUser.displayName,
        'userRole': roleName,
        'email': _googleUser.email,
        'profileUrl': _googleUser.photoURL,
        'timestamp': DateFormat('dd/MM/yyyy hh:mm').format(_timestamp),
      });
    }

    notifyListeners();

    return _googleUser;
  }
}
