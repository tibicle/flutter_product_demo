import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:product_management_demo/products/bloc/products_bloc.dart';
import 'package:product_management_demo/products/model/product.dart';
import 'package:product_management_demo/utils/navigation_route_util.gr.dart';
import '../../../utils/date_utils.dart';

class ProductWebGridView extends StatelessWidget {
  final List<Product> products;
  final ProductsBloc productsBloc;

  const ProductWebGridView(
      {Key? key, required this.products, required this.productsBloc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    screenSize(context);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenSize(context),
        childAspectRatio: screenSize(context) == 1 ? 3 : 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: itemBuilder,
      itemCount: products.length,
    );
  }

  int screenSize(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if (width > 1200) {
      return 4;
    } else if (width < 1200 && width > 840) {
      return 3;
    } else if (width < 840 && width > 530) {
      return 2;
    }
    return 1;
  }

  Widget itemBuilder(BuildContext context, int index) {
    var product = products[index];
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title(context, "Name:   ", product.name),
            SizedBox(height: 5),
            title(
                context,
                "Launch Date:   ",
                product.launchedAt
                        .tryParse("yyyy-MM-dd")
                        ?.getFormatedString("dd MMM, yyyy") ??
                    ''),
            SizedBox(height: 5),
            title(context, "Launched Site:   ", product.launchedSite),
            SizedBox(height: 5),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Ratings:   ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                Text("${product.ratings}"),
                Icon(
                  Icons.star,
                  size: 15,
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
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
                    await AutoRouter.of(context).push(
                        EditProduct(id: product.id, isUrlRedirection: false));
                    productsBloc.getProducts();
                  },
                  icon: Icon(
                    Icons.edit_rounded,
                    size: 15,
                  ),
                  label: Text("Edit"),
                ),
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
    );
  }

  Widget title(BuildContext context, String title, String value) => Expanded(
        child: Row(
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
