import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online_shopping/Model/category_model.dart';

class ProductController extends GetxController {
  var subcat = <String>[].obs;

  Future<void> getSubCategories(String title) async {
    subcat.clear();
    final data =
        await rootBundle.loadString("lib/services/category_model.json");
    final decode = categoryModelFromJson(data);

    final matched = decode.categories.firstWhere(
      (element) =>
          element.name.toLowerCase().trim() == title.toLowerCase().trim(),
      orElse: () => Category(name: '', subcategory: []),
    );

    subcat.addAll(matched.subcategory);
  }
}
