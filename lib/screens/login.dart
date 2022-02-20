import 'package:chat/helpers/main_constants.dart';
import 'package:chat/helpers/theme/text_styles.dart';
import 'package:chat/helpers/theme/ui_helpers.dart';
import 'package:chat/helpers/widgets/online_tribes/login_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../helpers/widgets/online_tribes/main_button.dart';
import '../../../helpers/widgets/online_tribes/custom_Checkbox.dart';

import '../controller.dart';
import 'chat.dart';

/* class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key); */

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(411, 809),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return GestureDetector(
      onTap: () {
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 41.w),
                      child: Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (!controller.isLogin.value)
                              TextFormField(
                                controller: controller.userNameController,
                                maxLength: 320,
                                autofillHints: [AutofillHints.email],
                                keyboardType: TextInputType.emailAddress,
                                enableSuggestions: true,
                                style: outlineInputTextFormFieldHintStyle,
                                decoration: InputDecoration(
                                  hintText: 'User Name',
                                ),
                              ),
                            TextFormField(
                              controller: controller.emailController,
                              maxLength: 320,
                              autofillHints: [AutofillHints.email],
                              keyboardType: TextInputType.emailAddress,
                              enableSuggestions: true,
                              style: outlineInputTextFormFieldHintStyle,
                              decoration: InputDecoration(
                                hintText: 'Email',
                              ),
                            ),
                            horizontalSpaceTiny,
                            TextFormField(
                              controller: controller.passwordController,
                              maxLength: 120,
                              keyboardType: TextInputType.text,
                              obscuringCharacter: '*',
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              style: outlineInputTextFormFieldHintStyle,
                              decoration: InputDecoration(
                                hintText: 'Password',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(children: [
                      Obx(
                        () => Center(
                          child: SlimRoundedButton(
                            onPress: () {
                              if (controller.isLogin.value) {
                                controller.performSignin();
                              } else {
                                controller.createUserToAuth();
                              }
                            },
                            title:
                                controller.isLogin.value ? 'LOGIN' : 'SIGN UP',
                            backgroundColour: kMainColor,
                            textColor: kColorWhite,
                            /* screenWidth: screeanwidth,
                                screenHeight: screeanheight, */
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: controller.toogleIsLogin,
                          child: Text(controller.isLogin.value
                              ? "I don't have account yet"
                              : "I have acount already"))
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
