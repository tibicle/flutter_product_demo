import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:product_management_demo/products/bloc/products_bloc.dart';
import 'package:product_management_demo/products/model/product.dart';
import 'package:product_management_demo/utils/date_utils.dart';
import 'package:product_management_demo/utils/navigation_route_util.gr.dart';

class ProductWebListView extends StatelessWidget {
  final List<Product> products;
  final ProductsBloc productsBloc;

  const ProductWebListView(
      {Key? key, required this.products, required this.productsBloc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 16),
      itemCount: products.length,
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemBuilder: itemBuilder,
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    var product = products[index];
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(0),
      child: IntrinsicHeight(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              title(context, "Name:   ", product.name),
              title(
                  context,
                  "Launch Date:   ",
                  product.launchedAt
                          .tryParse("yyyy-MM-dd hh:mm:ssz")
                          ?.getFormatedString("dd MMM, yyyy") ??
                      ''),
              title(context, "Launched Site:   ", product.launchedSite),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ratings:   ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                  RatingBarIndicator(
                    itemPadding: EdgeInsets.all(0),
                    rating: product.ratings,
                    itemSize: 20,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 10,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      alignment: Alignment.center,
                      minimumSize: MaterialStateProperty.all(Size(100, 30)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await AutoRouter.of(context)
                          .push(EditProduct(id: product.id));
                      productsBloc.getProducts();
                    },
                    icon: Icon(
                      Icons.edit_rounded,
                      size: 15,
                    ),
                    label: Text("Edit"),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(100, 30)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.redAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      productsBloc.deleteProduct(product.id, context);
                    },
                    icon: Icon(
                      Icons.delete,
                      size: 15,
                    ),
                    label: Text("Delete"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget title(BuildContext context, String title, String value) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            Expanded(child: Text(value))
          ],
        ),
      );
}
