import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online_shopping/Model/category_model.dart';

class ProductController extends GetxController {
  getSubCategories() async {
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decode = categoryModelFromJson(data);
  }
}
