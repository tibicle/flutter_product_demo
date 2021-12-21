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
      path: routeHome,
      name: "productlisting",
    ),
    AutoRoute(
      page: AddProductPage,
      path: "/$routeAddProduct",
      name: "AddProduct",
    ),
    AutoRoute(
      page: AddProductPage,
      path: "/$routeAddProduct/:id",
      name: "EditProduct",
    ),
  ],
)
class $AppRouter {}
