import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:online_shopping/consts/color.dart';
import 'package:online_shopping/consts/firebase_const.dart';
import 'package:online_shopping/consts/images.dart';
import 'package:online_shopping/consts/strings.dart';
import 'package:online_shopping/consts/styles.dart';
import 'package:online_shopping/views/auth_screen/Home/home.dart';
import 'package:online_shopping/views/auth_screen/login_screen.dart';
import 'package:online_shopping/widgets_common/applogo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      // Get.off(() => const LoginScreen());
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => const LoginScreen());
        } else {
          Get.to(() => const Home());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor, // Assuming redColor is defined in color.dart
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(icSplashBg, width: 300),
            ),
            const SizedBox(height: 20),
            applogoWidget(),
            const SizedBox(height: 10),
            const Text(
              appname,
              style: TextStyle(
                fontSize: 22,
                fontFamily: bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              appversion,
              style: TextStyle(color: Colors.white),
            ),
            const Spacer(),
            const Text(
              credits,
              style: TextStyle(
                color: Colors.white,
                fontFamily: semibold,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
