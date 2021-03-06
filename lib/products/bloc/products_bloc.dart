import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:product_management_demo/helper/local_database/db_error.dart';
import 'package:product_management_demo/products/model/product.dart';
import 'package:product_management_demo/products/repo/products_repo.dart';
import 'package:product_management_demo/products/ui/mobile/products_mobile_widget.dart';

class ProductsBloc extends ChangeNotifier {
  final ProductRepo _productRepo;
  List<Product>? products;
  ProductsBloc(this._productRepo);
  FilterType currentFilterType = FilterType.sortByName;
  var isList = true;

  void setLayoutType(bool isList) {
    this.isList = isList;
    notifyListeners();
  }

  void getProducts() async {
    products = await _productRepo.getProducts();
    sort(currentFilterType);
    notifyListeners();
  }

  void deleteProduct(String id, BuildContext context) async {
    var isDelete = await confirmationDialog(context);
    if (!isDelete) return;
    try {
      await _productRepo.deleteProduct(id);
      products?.removeWhere((element) => element.id == id);
    } catch (e) {
      if (e is DatabaseException) {
        var exception = e;
        print(exception.message);
      }
      print(e.toString());
    }
    notifyListeners();
  }

  Future<bool> confirmationDialog(BuildContext context) async {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        AutoRouter.of(context).pop(false);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        AutoRouter.of(context).pop(true);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Confirm"),
      content: Text("Are you sure you want to delete this product?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    var isDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    return Future.value(isDelete);
  }

  void sort(FilterType filterType) {
    switch (filterType) {
      case FilterType.sortByName:
        products?.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        notifyListeners();
        break;
      case FilterType.sortByRatings:
        products?.sort((a, b) {
          return b.ratings.compareTo(a.ratings);
        });
        notifyListeners();
        break;
      case FilterType.sortByLaunchdate:
        products?.sort((a, b) {
          return b.launchedAt.compareTo(a.launchedAt);
        });
        notifyListeners();
        break;
      case FilterType.sortByLaunchsite:
        products?.sort((a, b) {
          return a.launchedSite
              .toLowerCase()
              .compareTo(b.launchedSite.toLowerCase());
        });
        notifyListeners();
        break;
    }
  }
}
