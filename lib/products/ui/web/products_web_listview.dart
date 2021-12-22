import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:product_management_demo/products/bloc/products_bloc.dart';
import 'package:product_management_demo/products/model/product.dart';
import 'package:product_management_demo/utils/date_utils.dart';
import 'package:product_management_demo/utils/navigation_route_util.gr.dart';
import 'package:product_management_demo/widgets/ratings.dart';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Ratings(
                        ratings: product.ratings,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      InkWell(
                        onTap: () async {
                          await AutoRouter.of(context).push(EditProduct(
                              id: product.id, isUrlRedirection: false));
                          productsBloc.getProducts();
                        },
                        child: Icon(Icons.edit),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      InkWell(
                        onTap: () {
                          productsBloc.deleteProduct(product.id, context);
                        },
                        child: Icon(Icons.delete),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 18,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    product.launchedAt
                            .tryParse("yyyy-MM-dd")
                            ?.getFormatedString("dd MMM, yyyy") ??
                        '',
                  ),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 18,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    product.launchedSite,
                  ),
                ],
              ),
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
