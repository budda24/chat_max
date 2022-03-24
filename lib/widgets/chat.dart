import 'package:chat/helpers/theme/app_colors.dart';
import 'package:chat/infrastructure/auth.dart';
import 'package:chat/infrastructure/datebase.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class ChatWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();

    return StreamBuilder(
        stream: Database().feachChats(auth.currentUser!.uid),
        builder: (_, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              reverse: true,
              itemCount: streamSnapshot.data!.size,
              itemBuilder: (_, index) {
                bool isSender = streamSnapshot.data!.docs[index]['userId'] ==
                    auth.currentUser!.uid;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GetX<LoginController>(
                      initState: (state) async {
                        await controller.getName();
                      },
                      builder: (c) => Container(
                        width: 50,
                        child: Text(
                          controller.name.value,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                    Obx(() => Container(
                          width: 50,
                          child: Text(
                            controller.name.value,
                            textAlign: TextAlign.right,
                          ),
                        )),
                    BubbleSpecialThree(
                      text: streamSnapshot.data!.docs[index]['text'],
                      color: AppColors.darkOrangeColor,
                      tail: true,
                      isSender: isSender,
                      textStyle: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                );
              });
        });
  }
}
