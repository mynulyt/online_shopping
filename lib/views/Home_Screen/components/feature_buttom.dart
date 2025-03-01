import 'package:flutter/material.dart';
import 'package:online_shopping/consts/color.dart';
import 'package:online_shopping/consts/styles.dart';
import 'package:velocity_x/velocity_x.dart';

Widget featureHomeButtom({String? title, icon}) {
  return Column(
    children: [
      Image.asset(
        icon,
        width: 40,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.color(darkFontGrey).fontFamily(semibold).make(),
    ],
  )
      .box
      .width(200)
      .padding(const EdgeInsets.all(4))
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .white
      .outerShadowSm
      .roundedSM
      .make();
}
