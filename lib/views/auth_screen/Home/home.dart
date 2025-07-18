import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_shopping/Controller/home_controller.dart';
import 'package:online_shopping/consts/color.dart';
import 'package:online_shopping/consts/images.dart';
import 'package:online_shopping/consts/strings.dart';
import 'package:online_shopping/consts/styles.dart';
import 'package:online_shopping/views/Cart_Screen/cart_screen.dart';
import 'package:online_shopping/views/Home_Screen/home_screen.dart';
import 'package:online_shopping/views/Profile_Screen/profile_screen.dart';
import 'package:online_shopping/views/category_screen/category_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navBarItems = [
      BottomNavigationBarItem(
        icon: Image.asset(icHome, width: 26),
        label: home,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(icCategories, width: 26),
        label: topCategories,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(icCart, width: 26),
        label: cart,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(icProfile, width: 26),
        label: account,
      ),
    ];

    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () async {
        if (controller.currentNavIndex.value != 0) {
          controller.currentNavIndex.value = 0;
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Obx(
          () => IndexedStack(
            index: controller.currentNavIndex.value,
            children: navBody,
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            items: navBarItems,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
