import 'package:chat/helpers/theme/alert_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

final db = FirebaseFirestore.instance;

class Database {
  void addMessage(String message) async {
    FieldValue id = FieldValue.serverTimestamp();
    await db
        .collection('chat/MfGFtUTDbwZ5q7HG16jC/messahes')
        .add({'text': message.toString()}).catchError(
      (onError) => Get.showSnackbar(
        customSnackbar('Sign up failed because ${onError.message}'),
      ),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> feachChats() {
    return FirebaseFirestore.instance
        .collection('chat/MfGFtUTDbwZ5q7HG16jC/messages')
        .snapshots();
  }

 Future<void> createUser(String id,String email, String name) async {
    await db
        .collection('user')
        .doc(id)
        .set({'email': email, 'userName': name}).catchError(
      (onError) => Get.showSnackbar(
        customSnackbar('Sign up failed because ${onError.message}'),
      ),
    );
  }
}
