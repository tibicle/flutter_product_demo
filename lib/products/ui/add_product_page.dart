import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:product_management_demo/products/bloc/add_product_bloc.dart';
import 'package:product_management_demo/products/di/product_module.dart';
import 'package:product_management_demo/products/model/product.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  final Product? product;
  const AddProductPage({Key? key, this.product}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  late AddProductBloc _productsBloc;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // TODO: Use ProductBloc to add/edit/delete the product!
    _productsBloc = ProductsModule().getAddProductBloc();
    loadData();
  }

  void loadData() {
    if (widget.product != null) {
      _productsBloc.loadData(widget.product!);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Create the web and mobile widgets if required to demonstrate different designs for web and mobile
    // and return specific widgets
    return ChangeNotifierProvider<AddProductBloc>(
        create: (_) => _productsBloc,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title:
                  Text(widget.product == null ? "Add Product" : "Edit Product"),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Form(
                  key: _productsBloc.formKey,
                  child:
                      Consumer<AddProductBloc>(builder: (context, bloc, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            onChanged: _productsBloc.onNameChanged,
                            validator: _productsBloc.validateName,
                            initialValue: _productsBloc.name,
                            maxLines: 10,
                            minLines: 1,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              label: Text("Name",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor)),
                            ),
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () {
                              _productsBloc.selectDate(context);
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: _productsBloc.launchDate,
                                onChanged: _productsBloc.onLaunchDateChanged,
                                validator: _productsBloc.validateLaunchDate,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  label: Text("Launch Date",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            onChanged: _productsBloc.onlaunchSiteChanged,
                            validator: _productsBloc.validateLaunchSite,
                            initialValue: _productsBloc.launchSite,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              label: Text("Launch Site",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor)),
                            ),
                          ),
                          const SizedBox(height: 16),
                          RatingBar.builder(
                            initialRating: _productsBloc.ratings,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: _productsBloc.onRatingsChagned,
                          ),
                          if (bloc.ratingsError != null)
                            Text(
                              bloc.ratingsError ?? '',
                              style: TextStyle(
                                color: Theme.of(context).errorColor,
                                fontSize: 12,
                              ),
                            ),
                          Align(
                            child: ElevatedButton(
                              onPressed: () {
                                if (widget.product != null) {
                                  _productsBloc.editProduct(
                                      widget.product!, context);
                                } else {
                                  _productsBloc.addProduct(context);
                                }
                              },
                              child: const Text("Submit"),
                            ),
                          ),
                          if (bloc.dataBaseError != null)
                            Align(
                              child: Text(
                                bloc.dataBaseError ?? '',
                                style: TextStyle(
                                  color: Theme.of(context).errorColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
        });
  }
}
