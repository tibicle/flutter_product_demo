import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:product_management_demo/products/ui/add_product_page.dart';
import 'package:product_management_demo/products/ui/products_page.dart';
import 'package:product_management_demo/utils/route_const.dart';

import 'navigation_argument_const.dart';

class NavigationUtils {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Map<String, dynamic>? args = settings.arguments != null
        ? Map<String, dynamic>.from(settings.arguments as LinkedHashMap)
        : null;
    switch (settings.name) {
      case routeHome:
        return MaterialPageRoute(builder: (_) => ProductsPage());
      case routeAddProduct:
        return MaterialPageRoute(
            builder: (_) => AddProductPage(
                  product: args != null ? args[argProduct] : null,
                ));
      default:
        return _errorRoute("Page Not Found");
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(title: Text('Error')),
          body: Center(child: Text(message)));
    });
  }

  static void pushReplacement(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> push(BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  static void pop(BuildContext context, {dynamic args}) {
    Navigator.of(context).pop(args);
  }

  static Future<dynamic> pushAndRemoveUntil(
      BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.of(context).pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: arguments);
  }
}
