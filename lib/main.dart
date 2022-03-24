import 'package:chat/controller.dart';
import 'package:chat/screens/chatscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'bindings.dart';
import 'infrastructure/auth.dart';
import 'screens/loginScreen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().catchError((onError)=> print('catch error $onError'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
       getPages: [
         GetPage(name: '/', page: ()=> /* auth.currentUser == null ? */ LoginView()/*:  ChatScreen() */,binding: LoginBinding() )
       ],
    );
  }
}

