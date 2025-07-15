import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_shopping/Controller/profile_controller.dart';
import 'package:online_shopping/consts/consts.dart';
import 'package:online_shopping/widgets_common/bg_widget.dart';
import 'package:online_shopping/widgets_common/customs_textField.dart';
import 'package:online_shopping/widgets_common/our_buttom.dart';

class EditProfieScreen extends StatelessWidget {
  final dynamic data;
  const EditProfieScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //Edit image empty

              data['imageUrl'] == '' && controller.ProfileImagePath.isEmpty
                  ? Image.asset(
                      //asset image is must be change
                      imgProfile2,
                      width: 70,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  //if is data is not empty but, controller path is empty
                  : data['imageUrl'] != '' &&
                          controller.ProfileImagePath.isEmpty
                      ? Image.network(
                          data['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      //if both are empty
                      : Image.file(
                          File(controller.ProfileImagePath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),

              10.heightBox,
              ourButtom(
                  onPress: () {
                    controller.ChangeIamge(context);
                  },
                  color: redColor,
                  textColor: whiteColor,
                  title: "Change"),
              const Divider(),
              20.heightBox,
              CustomTextField(
                controller: controller.nameController,
                hint: nameHint,
                title: name,
                isPass: false,
              ),
              10.heightBox,
              CustomTextField(
                controller: controller.oldPasswordController,
                hint: passwordHint,
                title: oldpass,
                isPass: true,
              ),
              10.heightBox,
              CustomTextField(
                controller: controller.newPasswordController,
                hint: passwordHint,
                title: newpass,
                isPass: true,
              ),
              20.heightBox,
              controller.isloading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 60,
                      child: ourButtom(
                          onPress: () async {
                            controller.isloading(true);

                            //if image is not selected
                            if (controller.ProfileImagePath.value.isEmpty) {
                              await controller.UplaodProfileImage();
                            } else {
                              controller.profileImageLink = data['imageUrl'];
                            }
                            //if old password matches

                            if (data['password'] ==
                                controller.oldPasswordController.text) {
                              await controller.UpdateProfile(
                                name: controller.nameController.text,
                                imageUrl: controller.profileImageLink,
                                password: controller.newPasswordController.text,
                              );

                              VxToast.show(context, msg: "Updated");
                            }
                          },
                          color: redColor,
                          textColor: whiteColor,
                          title: "Save"),
                    ),
            ],
          )
              .box
              .shadowSm
              .white
              .rounded
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
              .make(),
        ),
      ),
    );
  }
}
