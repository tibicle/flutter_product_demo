import 'dart:async';

import 'package:get_storage/get_storage.dart';

class DBHelper {
  static late final box = GetStorage('products');
  static const tableProducts = "Product";

  static const dbFieldId = "id";
  static const dbFieldName = "name";
  static const dbFieldLaunchDate = "launchdate";
  static const dbFieldLaunchSite = "launchsite";
  static const dbFieldRatings = "ratings";

  static Future<void> add(List<Map<String, dynamic>> products) async {
    try {
      await box.initStorage;
      return await box.write("products", products);
    } catch (e) {
      print(e);
    }
  }

  static Future<List?> fetchAll() async {
    try {
      await box.initStorage;
      return box.read<List>("products");
    } catch (e) {
      print(e);
    }
  }
}
