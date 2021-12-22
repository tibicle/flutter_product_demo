import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:product_management_demo/products/bloc/products_bloc.dart';
import 'package:product_management_demo/products/model/product.dart';
import 'package:product_management_demo/utils/navigation_route_util.gr.dart';
import 'package:product_management_demo/widgets/ratings.dart';
import '../../../utils/date_utils.dart';

class ProductWebGridView extends StatelessWidget {
  final List<Product> products;
  final ProductsBloc productsBloc;

  const ProductWebGridView(
      {Key? key, required this.products, required this.productsBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    aspectRatio(context);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenSize(context),
        childAspectRatio: aspectRatio(context),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: itemBuilder,
      itemCount: products.length,
    );
  }

  double aspectRatio(BuildContext context) {
    int crossAxisCount = screenSize(context);
    var width = MediaQuery.of(context).size.width;
    switch (crossAxisCount) {
      case 4:
        if (width < 1290) return 1.8;
        if (width < 1410) return 2.0;
        return 2.2;
      case 3:
        if (width > 1080) return 2.2;
        if (width < 900) return 1.6;
        return 1.8;
      case 2:
        if (width > 750 && width < 900) return 2.2;
        if (width < 590) return 1.6;
        return 1.7;
      default:
        return 3;
    }
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
                Ratings(
                  ratings: product.ratings,
                ),
              ],
            ),
            SizedBox(height: 5),
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
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    await AutoRouter.of(context).push(
                        EditProduct(id: product.id, isUrlRedirection: false));
                    productsBloc.getProducts();
                  },
                  icon: Icon(Icons.edit),
                ),
                SizedBox(
                  width: 4,
                ),
                IconButton(
                  onPressed: () {
                    productsBloc.deleteProduct(product.id, context);
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
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
