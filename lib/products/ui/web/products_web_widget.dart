import 'package:flutter/material.dart';
import 'package:product_management_demo/products/model/product.dart';

class ProductsWebWidget extends StatefulWidget {
  final List<Product> products;

  const ProductsWebWidget({
    Key? key,
    required this.products,
  }) : super(key: key);


  @override
  _ProductsWebWidgetState createState() => _ProductsWebWidgetState();
}

class _ProductsWebWidgetState extends State<ProductsWebWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
