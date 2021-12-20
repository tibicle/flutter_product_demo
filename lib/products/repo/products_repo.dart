import 'package:product_management_demo/products/model/product.dart';
import 'package:product_management_demo/products/source/products_local_source.dart';

class ProductRepo {
  final ProductsLocalSource _productsLocalSource;

  ProductRepo(this._productsLocalSource);

  Future<List<Product>> getProducts() {
    return _productsLocalSource.getProducts();
  }

  Future<Product?> addProduct(
      String name, String launchedAt, String launchedSite, double ratings) {
    return _productsLocalSource.addProduct(
        name, launchedAt, launchedSite, ratings);
  }

  Future<Product> editProduct(String id, String name, String launchedAt,
      String launchedSite, double ratings) {
    return _productsLocalSource.editProduct(
        id, name, launchedAt, launchedSite, ratings);
  }

  Future<Product> deleteProduct(String id) {
    return _productsLocalSource.deleteProduct(id);
  }
}
