import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:product_management_demo/products/bloc/add_product_bloc.dart';
import 'package:product_management_demo/products/di/product_module.dart';
import 'package:product_management_demo/products/ui/mobile/product_add_mobile.dart';
import 'package:product_management_demo/products/ui/web/products_add_web.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  final bool isUrlRedirection;
  final String? id;
  const AddProductPage(
      {Key? key, @PathParam('id') this.id, this.isUrlRedirection = true})
      : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  late AddProductBloc _productsBloc;

  @override
  void initState() {
    super.initState();

    _productsBloc = ProductsModule().getAddProductBloc();
    if (widget.isUrlRedirection) {
      AutoRouter.of(context).pop();
    } else {
      loadData();
    }
  }

  void loadData() {
    if (widget.id != null) {
      _productsBloc.loadProduct(widget.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isUrlRedirection) return Container();
    return ChangeNotifierProvider<AddProductBloc>(
        create: (_) => _productsBloc,
        builder: (context, child) {
          return Consumer<AddProductBloc>(builder: (_, __, ___) {
            if (kIsWeb) {
              return AddProductWeb(
                productsBloc: _productsBloc,
                id: widget.id,
              );
            }
            return AddProductMobile(
              productsBloc: _productsBloc,
              id: widget.id,
            );
          });
        });
  }
}
