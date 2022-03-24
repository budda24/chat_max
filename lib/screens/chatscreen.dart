import 'package:chat/controller.dart';
import 'package:chat/helpers/theme/app_colors.dart';
import 'package:chat/helpers/theme/ui_helpers.dart';
import 'package:chat/helpers/widgets/online_tribes/main_button.dart';
import 'package:chat/infrastructure/auth.dart';
import 'package:chat/infrastructure/datebase.dart';
import 'package:chat/widgets/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  @override
  build(BuildContext context) {
    final controller = Get.find<LoginController>();


    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 400,
                child: ChatWidget(),
              ),
              Text('message'),
              TextField(
                keyboardType: TextInputType.text,
                controller: controller.messageController,
              ),
              SlimRoundedButton(
                backgroundColour: AppColors.primaryColor,
                onPress: () async {
                  await Database().addMessage(
                    message: controller.messageController.text,
                    userId: auth.currentUser!.uid,
                  );
                  controller.messageController.clear();
                },
                title: 'Send',
                textColor: AppColors.whiteColor,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () {},
        icon: Icon(Icons.account_tree),
      ),
    );
  }
}
