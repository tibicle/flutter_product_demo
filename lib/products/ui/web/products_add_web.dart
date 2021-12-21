import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:product_management_demo/products/bloc/add_product_bloc.dart';
import 'package:product_management_demo/utils/navigation_route_util.gr.dart';
import 'package:provider/provider.dart';

class AddProductWeb extends StatelessWidget {
  final AddProductBloc productsBloc;
  final String? id;

  AddProductWeb({required this.productsBloc, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddProductBloc>(
        create: (_) => productsBloc,
        builder: (context, child) {
          return Material(
            child: Column(
              children: [
                SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        SizedBox(width: 16),
                        IconButton(
                          onPressed: () {
                            AutoRouter.of(context).navigate(Productlisting());
                          },
                          icon: Icon(
                            Icons.list,
                            color: Theme.of(context).primaryColor,
                          ),
                          tooltip: "Product Listing",
                        ),
                        Text(
                          id == null ? "Add Product" : "Edit Product",
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    )),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Form(
                      key: productsBloc.formKey,
                      child: Consumer<AddProductBloc>(
                          builder: (context, bloc, child) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: productsBloc.nameCtr,
                                onChanged: productsBloc.onNameChanged,
                                validator: productsBloc.validateName,
                                // initialValue: _productsBloc.name,
                                maxLines: 10,
                                minLines: 1,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  label: Text("Name",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor)),
                                ),
                              ),
                              const SizedBox(height: 16),
                              GestureDetector(
                                onTap: () {
                                  productsBloc.selectDate(context);
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: productsBloc.launchDate,
                                    onChanged: productsBloc.onLaunchDateChanged,
                                    validator: productsBloc.validateLaunchDate,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      label: Text("Launch Date",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: productsBloc.launchSiteCtr,
                                onChanged: productsBloc.onlaunchSiteChanged,
                                validator: productsBloc.validateLaunchSite,
                                // initialValue: _productsBloc.launchSite,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  label: Text("Launch Site",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor)),
                                ),
                              ),
                              const SizedBox(height: 16),
                              RatingBar.builder(
                                initialRating: productsBloc.ratings,
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
                                onRatingUpdate: productsBloc.onRatingsChagned,
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
                                    if (id != null) {
                                      productsBloc.editProduct(id!, context);
                                    } else {
                                      productsBloc.addProduct(context);
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
              ],
            ),
          );
        });
  }
}
