import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_shopping/Controller/auth_controller.dart';
import 'package:online_shopping/consts/consts.dart';
import 'package:online_shopping/views/auth_screen/Home/home.dart';
import 'package:online_shopping/widgets_common/applogo_widget.dart';
import 'package:online_shopping/widgets_common/bg_widget.dart';
import 'package:online_shopping/widgets_common/customs_textField.dart';
import 'package:online_shopping/widgets_common/our_buttom.dart';

class SingupScreen extends StatefulWidget {
  const SingupScreen({super.key});

  @override
  State<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  bool isCheck = false;
  var controller = Get.put(AuthController());
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                applogoWidget(),
                5.heightBox,
                "Join the $appname".text.fontFamily(bold).white.size(18).make(),
                10.heightBox,
                Obx(
                  () => Column(
                    children: [
                      CustomTextField(
                        hint: nameHint,
                        title: name,
                        controller: nameController,
                        isPass: false,
                      ),
                      CustomTextField(
                        hint: emailHint,
                        title: email,
                        controller: emailController,
                        isPass: false,
                      ),
                      CustomTextField(
                          hint: passwordHint,
                          title: password,
                          controller: passwordController,
                          isPass: true),
                      CustomTextField(
                        hint: passwordHint,
                        title: retypPassword,
                        controller: passwordRetypeController,
                        isPass: true,
                      ),
                      5.heightBox,
                      Row(
                        children: [
                          Checkbox(
                            checkColor: redColor,
                            value: isCheck,
                            onChanged: (newValue) {
                              setState(() {
                                isCheck = newValue ?? false;
                              });
                            },
                          ),
                          5.widthBox,
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                    fontFamily: regular, color: fontGrey),
                                children: [
                                  TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: fontGrey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: termAndCond,
                                    style: TextStyle(
                                      color: redColor,
                                      fontFamily: regular,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " & ",
                                    style: TextStyle(
                                      color: fontGrey,
                                      fontFamily: regular,
                                    ),
                                  ),
                                  TextSpan(
                                    text: privacyPolicy,
                                    style: TextStyle(
                                      color: redColor,
                                      fontFamily: regular,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      controller.isloading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )
                          : ourButtom(
                              color: isCheck == true ? redColor : lightGrey,
                              title: signup,
                              textColor: whiteColor,
                              onPress: () async {
                                if (isCheck != false) {
                                  controller.isloading(true);
                                  try {
                                    await controller
                                        .signupMethod(
                                      context: context,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    )
                                        .then((value) {
                                      return controller.storeUserData(
                                        email: emailController.text,
                                        name: nameController.text,
                                        password: passwordController.text,
                                      );
                                    }).then((value) {
                                      VxToast.show(context, msg: loggedin);
                                      Get.offAll(() => const Home());
                                    });
                                  } catch (e) {
                                    auth.signOut();
                                    VxToast.show(context, msg: e.toString());
                                    controller.isloading(false);
                                  }
                                }
                              }).box.width(context.screenWidth - 50).make(),
                      5.heightBox,
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(fontFamily: bold, color: fontGrey),
                          children: [
                            TextSpan(
                              text: alreadyHaveAccount,
                              style: TextStyle(
                                fontFamily: regular,
                                color: fontGrey,
                              ),
                            ),
                            TextSpan(
                              text: login,
                              style: TextStyle(
                                fontFamily: bold,
                                color: redColor,
                              ),
                            ),
                          ],
                        ),
                      ).onTap(() {
                        Get.back();
                      }),
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
      ),
    );
  }
}
