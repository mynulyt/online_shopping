import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online_shopping/Model/category_model.dart';

class ProductController extends GetxController {
  var subcat = [];
  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decode = categoryModelFromJson(data);

    var s =
        decode.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }
}
