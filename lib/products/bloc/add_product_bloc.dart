import 'package:flutter/material.dart';
import 'package:product_management_demo/helper/local_database/db_error.dart';
import 'package:product_management_demo/products/model/product.dart';
import 'package:product_management_demo/products/repo/products_repo.dart';

class AddProductBloc extends ChangeNotifier {
  final ProductRepo _productRepo;

  final formKey = GlobalKey<FormState>();

  AddProductBloc(this._productRepo);

  String name = "";
  TextEditingController nameCtr = TextEditingController();
  TextEditingController launchDate = TextEditingController();
  String launchSite = "";
  TextEditingController launchSiteCtr = TextEditingController();
  double ratings = -1;
  String? ratingsError;
  String? dataBaseError;

  onNameChanged(String value) => name = value;
  onLaunchDateChanged(String value) => launchDate.text = value;
  onlaunchSiteChanged(String value) => launchSite = value;
  onRatingsChagned(double value) => ratings = value;

  String? validateName(String? value) {
    return (value?.isEmpty ?? false) ? "Enter Name" : null;
  }

  String? validateLaunchDate(String? value) {
    return (value?.isEmpty ?? false) ? "Enter Launch Date" : null;
  }

  String? validateLaunchSite(String? value) {
    return (value?.isEmpty ?? false) ? "Enter Launch site" : null;
  }

  String? validateRatings(String? value) {
    String? isvalid;
    if (value?.isEmpty ?? false) {
      isvalid = "Enter Ratings";
    } else {
      var rat = double.tryParse(value!);
      if (rat != null && rat > 5) {
        isvalid = "Enter valid Rating";
      }
    }
    return isvalid;
  }

  void addProduct(BuildContext context) async {
    ratingsError = null;
    dataBaseError = null;
    var isValid = (formKey.currentState?.validate() ?? true);
    if (ratings < 0) {
      isValid = false;
      ratingsError = "Add Ratings";
    }
    notifyListeners();
    if (!isValid) return;

    try {
      var product = await _productRepo.addProduct(
          name, launchDate.text, launchSite, ratings);
      Navigator.of(context).pop(product);
    } catch (e) {
      if (e is DatabaseException) {
        var exception = e;
        dataBaseError = exception.message;
      }
      print(e.toString());
    }
  }

  void selectDate(BuildContext context) async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(0),
        lastDate: DateTime(3000));
    if (date != null) {
      launchDate.text = date.toString();
    }
  }

  void editProduct(String id, BuildContext context) async {
    ratingsError = null;
    dataBaseError = null;
    var isValid = (formKey.currentState?.validate() ?? true);
    if (ratings < 0) {
      isValid = false;
      ratingsError = "Add Ratings";
    }
    notifyListeners();
    if (!isValid) return;

    try {
      var editedProduct = await _productRepo.editProduct(
          id, name, launchDate.text, launchSite, ratings);
      Navigator.of(context).pop(editedProduct);
    } catch (e) {
      if (e is DatabaseException) {
        var exception = e;
        dataBaseError = exception.message;
      }
      print(e.toString());
    }
  }

  void loadData(Product product) {
    launchDate.text = product.launchedAt;
    name = product.name;
    nameCtr.text = product.name;
    ratings = product.ratings;
    launchSite = product.launchedSite;
    launchSiteCtr.text = product.launchedSite;
    notifyListeners();
  }

  void loadProduct(String id) async {
    var product = await _productRepo.getProductByid(id);
    loadData(product);
  }
}
