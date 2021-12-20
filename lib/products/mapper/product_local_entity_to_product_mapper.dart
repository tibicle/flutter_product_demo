import 'package:product_management_demo/base/base_mapper_two_way.dart';
import 'package:product_management_demo/products/model/entity/product_local_entity.dart';
import 'package:product_management_demo/products/model/product.dart';

class ProductLocalEntityToProductListMapper
    extends BaseMapperTwoWay<List<ProductLocalEntity>, List<Product>> {
  @override
  List<Product> map(List<ProductLocalEntity> t) {
    return t
        .map((e) => Product(
              id: e.id,
              name: e.name,
              ratings: e.ratings,
              launchedSite: e.launchedSite,
              launchedAt: e.launchedAt,
            ))
        .toList();
  }

  @override
  List<ProductLocalEntity> reverseMap(List<Product> v) {
    return v
        .map((e) => ProductLocalEntity(
            id: e.id,
            name: e.name,
            launchedAt: e.launchedAt,
            launchedSite: e.launchedSite,
            ratings: e.ratings))
        .toList();
  }
}
