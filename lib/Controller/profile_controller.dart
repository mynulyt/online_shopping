import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_shopping/consts/consts.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var ProfileImagePath = ''.obs;
  var profileImageLink = '';
  var isloading = false.obs;
  //Text Field for Edit profile
  var nameController = TextEditingController();
  var passController = TextEditingController();
  ChangeIamge(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      ProfileImagePath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  UplaodProfileImage() async {
    var filename = basename(ProfileImagePath.value);
    var destination = 'image/${crurrentUser!.uid}/filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(ProfileImagePath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  UpdateProfile(
      {required String name,
      required String password,
      required String imageUrl}) async {
    var store = firestore.collection(usersCollection).doc(crurrentUser!.uid);
    await store.set({
      'name': name,
      'password': password,
      'imageUrl': imageUrl,
    }, SetOptions(merge: true));
    isloading(false);
  }
}
