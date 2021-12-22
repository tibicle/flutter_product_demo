import 'package:product_management_demo/helper/local_database/db_error.dart';
import 'package:product_management_demo/helper/local_database/db_helper.dart';
import 'package:product_management_demo/products/mapper/product_local_data_list_mapper.dart';
import 'package:product_management_demo/products/model/entity/product_local_entity.dart';
import 'package:product_management_demo/products/model/product.dart';
import 'package:uuid/uuid.dart';

class ProductsLocalSource {
  final ProductLocalEntityToProductMapper _mapper;

  ProductsLocalSource(this._mapper);

  Future<List<Product>> getProducts() async {
    var datalist = await DBHelper.fetchAll();
    List<Product> products = [];
    datalist?.forEach((element) {
      products.add(_mapper.reverseMap(ProductLocalEntity.fromJson(element)));
    });
    return Future.value(products);
  }

  Future<Product> getProductByid(String id) async {
    var datalist = await DBHelper.fetchAll();
    List<Product> products = [];
    datalist?.forEach((element) {
      products.add(_mapper.reverseMap(ProductLocalEntity.fromJson(element)));
    });
    var productIndex = products.indexWhere((element) => element.id == id);
    if (productIndex == -1) {
      throw DatabaseException("Product does not exists in database");
    } else {
      return Future.value(products.elementAt(productIndex));
    }
  }

  Future<Product?> addProduct(String name, String launchedAt,
      String launchedSite, double ratings) async {
    var uuid = Uuid().v1();
    ProductLocalEntity localProduct = ProductLocalEntity(
      id: uuid,
      name: name,
      launchedAt: launchedAt,
      launchedSite: launchedSite,
      ratings: ratings,
    );
    var datalist = await DBHelper.fetchAll();
    List<ProductLocalEntity> localProducts = [];
    datalist?.forEach((element) {
      localProducts.add(ProductLocalEntity.fromJson(element));
    });
    var productContains = localProducts.indexWhere(
        (element) => element.name.toLowerCase() == name.toLowerCase());
    if (productContains != -1) {
      throw DatabaseException(
          "Product with this name already exists  in database");
    } else {
      localProducts.add(localProduct);
      var insertDataList = localProducts.map((e) => e.toJson()).toList();
      await DBHelper.add(insertDataList);
      return Future.value(_mapper.reverseMap(localProduct));
    }
  }

  Future<Product> editProduct(String id, String name, String launchedAt,
      String launchedSite, double ratings) async {
    ProductLocalEntity localProduct = ProductLocalEntity(
      id: id,
      name: name,
      launchedAt: launchedAt,
      launchedSite: launchedSite,
      ratings: ratings,
    );
    var datalist = await DBHelper.fetchAll();
    List<ProductLocalEntity> localProducts = [];
    datalist?.forEach((element) {
      localProducts.add(ProductLocalEntity.fromJson(element));
    });

    var currentProductIndex =
        localProducts.indexWhere((element) => element.id == id);

    if (currentProductIndex == -1) {
      throw DatabaseException("Product does not exists in database");
    } else {
      localProducts.removeWhere((element) => element.id == id);
      var duplicateNameproductIndex = localProducts.indexWhere(
          (element) => element.name.toLowerCase() == name.toLowerCase());
      if (duplicateNameproductIndex != -1) {
        throw DatabaseException(
            "Product with this name already exists in database");
      } else {
        localProducts.add(localProduct);
        var insertDataList = localProducts.map((e) => e.toJson()).toList();
        await DBHelper.add(insertDataList);
        return Future.value(_mapper.reverseMap(localProduct));
      }
    }
  }

  Future<Product> deleteProduct(String id) async {
    var datalist = await DBHelper.fetchAll();
    List<ProductLocalEntity> localProducts = [];
    datalist?.forEach((element) {
      localProducts.add(ProductLocalEntity.fromJson(element));
    });
    var productIndex = localProducts.indexWhere((element) => element.id == id);
    if (productIndex == -1) {
      throw DatabaseException("Product does not exists in database");
    } else {
      ProductLocalEntity localProduct = localProducts.removeAt(productIndex);
      var insertDataList = localProducts.map((e) => e.toJson()).toList();
      await DBHelper.add(insertDataList);
      return Future.value(_mapper.reverseMap(localProduct));
    }
  }
}
