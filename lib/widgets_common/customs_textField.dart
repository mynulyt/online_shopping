import 'package:flutter/material.dart';
import 'package:online_shopping/consts/color.dart';
import 'package:online_shopping/consts/styles.dart';
import 'package:velocity_x/velocity_x.dart';

Widget CustomTextField({
  String? title,
  String? hint,
  controller,
  isPass,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
            hintStyle: const TextStyle(
              fontFamily: semibold,
              color: textfieldGrey,
            ),
            hintText: hint,
            isDense: true,
            fillColor: lightGrey,
            filled: true,
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: redColor),
            )),
      ),
      5.heightBox,
    ],
  );
}
