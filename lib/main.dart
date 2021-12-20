import 'package:flutter/material.dart';
import 'package:product_management_demo/products/ui/add_product_page.dart';
import 'package:product_management_demo/products/ui/products_page.dart';
import 'package:product_management_demo/utils/navigation_utils.dart';
import 'package:product_management_demo/utils/route_const.dart';

void main() {
  mainDelegate();
}

void mainDelegate() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Management App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: routeHome,
      onGenerateRoute: NavigationUtils.generateRoute,
    );
  }
}
