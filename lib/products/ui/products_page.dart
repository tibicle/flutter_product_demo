import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:product_management_demo/products/bloc/products_bloc.dart';
import 'package:product_management_demo/products/di/product_module.dart';
import 'package:product_management_demo/products/ui/mobile/products_mobile_widget.dart';
import 'package:product_management_demo/products/ui/web/products_web_widget.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late ProductsBloc _productsBloc;

  @override
  void initState() {
    super.initState();
    _productsBloc = ProductsModule().getProductsBloc();
    _productsBloc.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductsBloc>(
        create: (_) => _productsBloc,
        builder: (context, child) {
          return Consumer<ProductsBloc>(builder: (context, bloc, child) {
            if (kIsWeb) {
              return ProductsWebWidget(
                products: bloc.products ?? [],
                productsBloc: _productsBloc,
              );
            }
            return ProductsMobileWidget(
              products: bloc.products ?? [],
              productsBloc: _productsBloc,
            );
          });
        });
  }
}
