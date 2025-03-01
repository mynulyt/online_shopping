import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_shopping/consts/consts.dart';
import 'package:online_shopping/views/category_screen/item_detailes.dart';
import 'package:online_shopping/widgets_common/bg_widget.dart';

class CategoriesDetails extends StatelessWidget {
  final String? title;
  const CategoriesDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title!.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          child: Column(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      6,
                      (index) => "Baby clothing"
                          .text
                          .fontFamily(semibold)
                          .size(12)
                          .color(darkFontGrey)
                          .makeCentered()
                          .box
                          .roundedSM
                          .white
                          .size(120, 50)
                          .margin(const EdgeInsets.symmetric(horizontal: 4))
                          .make()),
                ),
              ),
              20.heightBox,
              //Iteam for

              Expanded(
                  child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 6,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 250,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              imgFc1,
                              width: 200,
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                            10.heightBox,
                            "Hp Laptop 16/256"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            10.heightBox,
                            "\$600"
                                .text
                                .color(redColor)
                                .fontFamily(bold)
                                .size(16)
                                .make()
                          ],
                        )
                            .box
                            .outerShadowSm
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .roundedSM
                            .padding(const EdgeInsets.all(12))
                            .white
                            .make()
                            .onTap(() {
                          Get.to(() => const IteamDetails(title: "Fake Iteam"));
                        });
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
