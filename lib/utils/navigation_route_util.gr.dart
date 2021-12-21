// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../products/ui/add_product_page.dart' as _i2;
import '../products/ui/products_page.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    Products.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.ProductsPage());
    },
    AddProduct.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AddProductArgs>(
          orElse: () => AddProductArgs(id: pathParams.optString('id')));
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.AddProductPage(
              key: args.key,
              id: args.id,
              isUrlRedirection: args.isUrlRedirection));
    },
    EditProduct.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EditProductArgs>(
          orElse: () => EditProductArgs(id: pathParams.optString('id')));
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.AddProductPage(
              key: args.key,
              id: args.id,
              isUrlRedirection: args.isUrlRedirection));
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig('/#redirect',
            path: '/', redirectTo: '/products', fullMatch: true),
        _i3.RouteConfig(Products.name, path: '/products'),
        _i3.RouteConfig(AddProduct.name, path: '/products/add'),
        _i3.RouteConfig(EditProduct.name, path: '/products/add/:id')
      ];
}

/// generated route for [_i1.ProductsPage]
class Products extends _i3.PageRouteInfo<void> {
  const Products() : super(name, path: '/products');

  static const String name = 'Products';
}

/// generated route for [_i2.AddProductPage]
class AddProduct extends _i3.PageRouteInfo<AddProductArgs> {
  AddProduct({_i4.Key? key, String? id, bool isUrlRedirection = true})
      : super(name,
            path: '/products/add',
            args: AddProductArgs(
                key: key, id: id, isUrlRedirection: isUrlRedirection),
            rawPathParams: {'id': id});

  static const String name = 'AddProduct';
}

class AddProductArgs {
  const AddProductArgs({this.key, this.id, this.isUrlRedirection = true});

  final _i4.Key? key;

  final String? id;

  final bool isUrlRedirection;

  @override
  String toString() {
    return 'AddProductArgs{key: $key, id: $id, isUrlRedirection: $isUrlRedirection}';
  }
}

/// generated route for [_i2.AddProductPage]
class EditProduct extends _i3.PageRouteInfo<EditProductArgs> {
  EditProduct({_i4.Key? key, String? id, bool isUrlRedirection = true})
      : super(name,
            path: '/products/add/:id',
            args: EditProductArgs(
                key: key, id: id, isUrlRedirection: isUrlRedirection),
            rawPathParams: {'id': id});

  static const String name = 'EditProduct';
}

class EditProductArgs {
  const EditProductArgs({this.key, this.id, this.isUrlRedirection = true});

  final _i4.Key? key;

  final String? id;

  final bool isUrlRedirection;

  @override
  String toString() {
    return 'EditProductArgs{key: $key, id: $id, isUrlRedirection: $isUrlRedirection}';
  }
}
