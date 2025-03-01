import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_shopping/consts/consts.dart';

class AuthController extends GetxController {
  var isloading = false.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Future<UserCredential?> loginMethod({context}) async {
    try {
      return await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message ?? "Login failed");
      return null;
    }
  }

  Future<UserCredential?> signupMethod({email, password, context}) async {
    try {
      return await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message ?? "Signup failed");
      return null;
    }
  }

  Future<void> storeUserData({email, name, password}) async {
    final user = auth.currentUser;
    if (user != null) {
      await firestore.collection(usersCollection).doc(user.uid).set({
        'name': name,
        'email': email,
        'password': password,
        'imageUrl': '',
        'id': crurrentUser!.uid,
        'cart_count': "00",
        'order_count': "00",
        'wishlist_count': "00",
      });
    }
  }

  Future<void> signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
