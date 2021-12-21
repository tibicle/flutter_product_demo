import 'package:auto_route/auto_route.dart';
import 'package:product_management_demo/products/ui/add_product_page.dart';
import 'package:product_management_demo/products/ui/products_page.dart';
import 'package:product_management_demo/utils/route_const.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: ProductsPage,
      initial: true,
      path: "/$routeHome",
      name: "products",
    ),
    AutoRoute(
      page: AddProductPage,
      path: "/$routeHome/$routeAddProduct",
      name: "addProduct",
    ),
    AutoRoute(
      page: AddProductPage,
      path: "/$routeHome/$routeAddProduct/:id",
      name: "editProduct",
    ),
  ],
)
class $AppRouter {}
