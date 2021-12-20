import 'package:product_management_demo/helper/local_database/db_helper.dart';

class ProductLocalEntity {
  String id;
  String name;
  String launchedAt;
  String launchedSite;
  double ratings;

  ProductLocalEntity({
    required this.id,
    required this.name,
    required this.launchedAt,
    required this.launchedSite,
    required this.ratings,
  });

  factory ProductLocalEntity.fromJson(Map<String, dynamic> map) {
    return ProductLocalEntity(
      id: map[DBHelper.dbFieldId],
      name: map[DBHelper.dbFieldName],
      launchedAt: map[DBHelper.dbFieldLaunchDate],
      launchedSite: map[DBHelper.dbFieldLaunchSite],
      ratings: map[DBHelper.dbFieldRatings],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      DBHelper.dbFieldId: id,
      DBHelper.dbFieldName: name,
      DBHelper.dbFieldLaunchDate: launchedAt,
      DBHelper.dbFieldLaunchSite: launchedSite,
      DBHelper.dbFieldRatings: ratings,
    };
  }
}
