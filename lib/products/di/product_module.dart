import 'package:product_management_demo/products/bloc/add_product_bloc.dart';
import 'package:product_management_demo/products/bloc/products_bloc.dart';
import 'package:product_management_demo/products/mapper/product_local_data_list_mapper.dart';
import 'package:product_management_demo/products/mapper/product_local_entity_to_product_mapper.dart';
import 'package:product_management_demo/products/repo/products_repo.dart';
import 'package:product_management_demo/products/source/products_local_source.dart';

class ProductsModule {
  static final _instance = ProductsModule._internal();

  ProductsModule._internal();

  factory ProductsModule() {
    return _instance;
  }

  ProductsBloc getProductsBloc() {
    return ProductsBloc(getProductRepo());
  }

  AddProductBloc getAddProductsBloc() {
    return AddProductBloc(getProductRepo());
  }

  AddProductBloc getAddProductBloc() {
    return AddProductBloc(getProductRepo());
  }

  ProductRepo getProductRepo() {
    return ProductRepo(getProductsLocalSource());
  }

  ProductsLocalSource getProductsLocalSource() {
    return ProductsLocalSource(
      getProductListMapper(),
    );
  }

  ProductLocalEntityToProductListMapper getLocalEntityToProductMapper() {
    return ProductLocalEntityToProductListMapper();
  }

  ProductLocalEntityToProductMapper getProductListMapper() {
    return ProductLocalEntityToProductMapper();
  }
}
