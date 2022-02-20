import 'package:chat/controller.dart';
import 'package:chat/helpers/theme/app_colors.dart';
import 'package:chat/helpers/widgets/online_tribes/main_button.dart';
import 'package:chat/infrastructure/datebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              width: double.infinity - 20,
              height: 500,
              child: StreamBuilder(
                stream: Database().feachChats(),
                builder: (_, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Container(
                    margin: EdgeInsets.only(top: 120),
                    child: ListView.builder(
                        itemCount: streamSnapshot.data!.size,
                        itemBuilder: (_, index) {
                          return Text(streamSnapshot.data!.docs[index]['text']);
                        }),
                  );
                },
              ),
            ),
            Column(
              children: [
                Text('message'),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: controller.messageController,
                ),
                SlimRoundedButton(
                  backgroundColour: AppColors.primaryColor,
                  onPress: () async {
                    /* await Database().feachChats()
                            .listen((event) {
                          event.docs.forEach((element) {
                            print(element['text']);
                          });
                        }); */
                    Database().addMessage(controller.messageController.text);
                  },
                  title: 'Send',
                  textColor: AppColors.whiteColor,
                )
              ],
            ),
          ]),
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () {},
        icon: Icon(Icons.account_tree),
      ),
    );
  }
}
