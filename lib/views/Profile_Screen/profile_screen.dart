import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_shopping/Controller/auth_controller.dart';
import 'package:online_shopping/Controller/profile_controller.dart';
import 'package:online_shopping/consts/consts.dart';
import 'package:online_shopping/consts/list.dart';
import 'package:online_shopping/services/firestore_services.dart';
import 'package:online_shopping/views/Home_Screen/components/details_cart.dart';
import 'package:online_shopping/views/Profile_Screen/edit_profie_screen.dart';
import 'package:online_shopping/views/auth_screen/login_screen.dart';
import 'package:online_shopping/widgets_common/bg_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            "User not logged in",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(user.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];

              return SafeArea(
                child: Column(
                  children: [
                    // Edit profile button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.edit,
                          color: whiteColor,
                        ),
                      ).onTap(() {
                        controller.nameController.text = data['name'];
                        controller.passController.text = data['password'];
                        Get.to(() => EditProfieScreen(data: data));
                      }),
                    ),
                    // User info section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          data['imageUrl'] == ''
                              ? Image.asset(
                                  imgProfile2,
                                  width: 70,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make()
                              : Image.network(
                                  data['imageUrl'],
                                  width: 70,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make(),
                          10.heightBox,
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "${data['name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(whiteColor)
                                      .make(),
                                  5.heightBox,
                                  "${data['email']}"
                                      .text
                                      .color(whiteColor)
                                      .make(),
                                ],
                              ),
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: whiteColor,
                              ),
                            ),
                            onPressed: () async {
                              await Get.put(AuthController())
                                  .signoutMethod(context);
                              Get.offAll(() => const LoginScreen());
                            },
                            child:
                                "Logout".text.fontFamily(semibold).white.make(),
                          )
                        ],
                      ),
                    ),
                    10.heightBox,
                    // Cart, wishlist, order stats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DetailsCart(
                          count: data['cart_count'],
                          title: "In our cart",
                          Width: context.screenWidth / 3.4,
                        ),
                        DetailsCart(
                          count: data['wishlist_count'],
                          title: "Wish List",
                          Width: context.screenWidth / 3.4,
                        ),
                        DetailsCart(
                          count: data['order_count'],
                          title: "your Order",
                          Width: context.screenWidth / 3.4,
                        ),
                      ],
                    ),
                    // Button list section
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.asset(
                            profileButtonIcon[index],
                            width: 22,
                          ),
                          title: profileButtonList[index]
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: lightGrey,
                        );
                      },
                      itemCount: profileButtonList.length,
                    )
                        .box
                        .white
                        .margin(const EdgeInsets.all(12))
                        .rounded
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .shadowSm
                        .make()
                        .box
                        .color(redColor)
                        .make(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
