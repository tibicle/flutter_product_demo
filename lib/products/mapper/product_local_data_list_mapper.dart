import 'package:product_management_demo/base/base_mapper_two_way.dart';
import 'package:product_management_demo/products/model/entity/product_local_entity.dart';
import 'package:product_management_demo/products/model/product.dart';

class ProductLocalEntityToProductMapper
    extends BaseMapperTwoWay<Product, ProductLocalEntity> {
  @override
  Product reverseMap(ProductLocalEntity t) {
    return Product(
        id: t.id,
        name: t.name,
        ratings: t.ratings,
        launchedSite: t.launchedSite,
        launchedAt: t.launchedAt);
  }

  @override
  ProductLocalEntity map(Product v) {
    return ProductLocalEntity(
        id: v.id,
        name: v.name,
        launchedAt: v.launchedAt,
        launchedSite: v.launchedSite,
        ratings: v.ratings);
  }
}
