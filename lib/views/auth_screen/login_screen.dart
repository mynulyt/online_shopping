import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_shopping/Controller/auth_controller.dart';
import 'package:online_shopping/consts/color.dart';
import 'package:online_shopping/consts/list.dart';
import 'package:online_shopping/consts/strings.dart';
import 'package:online_shopping/consts/styles.dart';
import 'package:online_shopping/views/auth_screen/Home/home.dart';
import 'package:online_shopping/views/auth_screen/singup_screen.dart';
import 'package:online_shopping/widgets_common/applogo_widget.dart';
import 'package:online_shopping/widgets_common/bg_widget.dart';
import 'package:online_shopping/widgets_common/customs_textField.dart';
import 'package:online_shopping/widgets_common/our_buttom.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              5.heightBox,
              "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
              10.heightBox,
              Obx(
                () => Column(
                  children: [
                    CustomTextField(
                      hint: emailHint,
                      title: email,
                      isPass: false,
                      controller: controller.emailController,
                    ),
                    CustomTextField(
                      hint: passwordHint,
                      title: password,
                      isPass: true,
                      controller: controller.passwordController,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Handle forgot password action
                        },
                        child: forgetPassword.text.make(),
                      ),
                    ),
                    5.heightBox,
                    controller.isloading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : ourButtom(
                            color: redColor,
                            title: login,
                            textColor: whiteColor,
                            onPress: () async {
                              controller.isloading(true);
                              await controller
                                  .loginMethod(context: context)
                                  .then((value) {
                                if (value != null) {
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => const Home());
                                } else {
                                  controller.isloading(false);
                                }
                              });
                            },
                          ).box.width(context.screenWidth - 50).make(),
                    5.heightBox,
                    CreateNewAccount.text.color(fontGrey).make(),
                    5.heightBox,
                    ourButtom(
                      color: redColor,
                      title: signup,
                      textColor: whiteColor,
                      onPress: () {
                        Get.to(() => const SingupScreen());
                      },
                    ).box.width(context.screenWidth - 50).make(),
                    5.heightBox,
                    loginWith.text.color(fontGrey).make(),
                    5.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: CircleAvatar(
                            backgroundColor: lightGrey,
                            radius: 15.0,
                            child: Image.asset(
                              socialIconList[index],
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadowSm
                    .make(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
