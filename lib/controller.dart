import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'helpers/theme/alert_styles.dart';
import 'infrastructure/auth.dart';
import 'infrastructure/datebase.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController messageController = TextEditingController();

  var isLogin = true.obs;
  toogleIsLogin() {
    isLogin.value = !isLogin.value;
  }

  bool validateSigninForm({
    required TextEditingController email,
    required TextEditingController password,
  }) {
    /* isEmail valid */
    if (!GetUtils.isEmail(email.text)) {
      email.clear();
      Get.showSnackbar(
        customSnackbar('Email is Invalid'),
      );
      return false;
    }
    /* isLenght < 8 */
    if (!GetUtils.isLengthGreaterThan(password.text, 8)) {
      Get.showSnackbar(
        customSnackbar('Password should contain from 8 to 16 characters'),
      );
      password.clear();
      return false;
    }
/* minimum eight characters, at least one letter and one number */
    RegExp regExpPassword = RegExp(
      r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$",
      caseSensitive: false,
      multiLine: false,
    );
    if (!regExpPassword.hasMatch(password.text)) {
      Get.showSnackbar(
        customSnackbar(
            'Password should contain at least one letter and one number'),
      );

      password.clear();
      return false;
    } else {
      return true;
    }
  }

  Future<void> performSignin() async {
    if (validateSigninForm(
        email: emailController, password: passwordController)) {
      var userEmails =
          await auth.fetchSignInMethodsForEmail(emailController.text);
      if (userEmails.isEmpty) {
        Get.showSnackbar(customSnackbar("we couldn't find currant email"));
      } else {
        try {
          await auth
              .signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text)
              .then((value) {});
        } on FirebaseAuthException catch (error) {
          customSnackbar("Sign in failed because ${error.message ?? ''}");
        }
      }
    }
  }

  Future<void> createUserToAuth() async {
    try {
      final List userEmails =
          await auth.fetchSignInMethodsForEmail(emailController.text);
      if (userEmails.isEmpty) {
        final userCredential = await auth.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        print(userCredential.user!.uid);
        if (userCredential.user != null) {
        await  Database()
              .createUser(userCredential.user!.uid,emailController.text, userNameController.text);
        }
      } else {
        Get.showSnackbar(customSnackbar('Email Already Exists'));
      }
    } on FirebaseAuthException catch (error) {
      Get.showSnackbar(
          customSnackbar('Sign up failed because ${error.message}'));
    }
  }
}
