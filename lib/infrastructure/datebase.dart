import 'package:chat/helpers/theme/alert_styles.dart';
import 'package:chat/infrastructure/auth.dart';
import 'package:chat/screens/loginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

final db = FirebaseFirestore.instance;

class Database {
  Future<void> addMessage(
      {required String message, required String userId}) async {
    FieldValue id = FieldValue.serverTimestamp();
    await db.collection('chat/').add({
      'text': message.toString(),
      'createdAt': id,
      'userId': userId,
      'userName': auth.currentUser!.displayName,
    }).catchError(
      (onError) => Get.showSnackbar(
        customSnackbar('Sign up failed because ${onError.message}'),
      ),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> feachChats(String userId) {
    return FirebaseFirestore.instance
        .collection('chat/')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> createUser(String id, String email, String name) async {
    await db
        .collection('user')
        .doc(id)
        .set({'email': email, 'userName': name}).catchError(
      (onError) => Get.showSnackbar(
        customSnackbar('Sign up failed because ${onError.message}'),
      ),
    );
  }

  Future<String> featchUser(String id) async {
    var user = await db.collection('user').doc(id).get();
    return user['userName'];
  }
}
