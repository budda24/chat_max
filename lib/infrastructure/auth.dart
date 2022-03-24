import 'package:chat/helpers/theme/alert_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'datebase.dart';

final auth = FirebaseAuth.instance;
class Auth{
  Future<void> logInExistingUser(String email, String password) async {
    try {
      final List userEmails =
          await auth.fetchSignInMethodsForEmail(email);
      if (userEmails.isEmpty) {
        Get.showSnackbar(customSnackbar("we couldn't find currant email"));
      } else {
        await auth
            .signInWithEmailAndPassword(
                email: email, password: password)
            .then((value) {

        });
      }
    } on FirebaseAuthException catch (error) {
      Get.showSnackbar(
          customSnackbar("Sign in failed because ${error.message ?? ''}"));
    }
  }
}

 Future<void> createUserToAuth(String email, String password, String name) async {
    try {
      final List userEmails =
          await auth.fetchSignInMethodsForEmail(email );
      if (userEmails.isEmpty) {
        final userCredential = await auth.createUserWithEmailAndPassword(
            email:email, password: password);
        print(userCredential.user!.uid);
        if (userCredential.user != null) {
          /* user.id = userCredential.user!.uid; */
          await Database().createUser(auth.currentUser!.uid, email, name);
        }
      } else {
         Get.showSnackbar(customSnackbar('Email Already Exists'));
      }
    } on FirebaseAuthException catch (error) {
      Get.showSnackbar(customSnackbar('Sign up failed because ${error.message}'));
    }
  }