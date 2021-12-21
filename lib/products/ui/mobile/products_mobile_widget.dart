import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:product_management_demo/products/bloc/products_bloc.dart';
import 'package:product_management_demo/products/model/product.dart';
import 'package:product_management_demo/utils/date_utils.dart';
import 'package:product_management_demo/utils/navigation_route_util.gr.dart';

class ProductsMobileWidget extends StatefulWidget {
  final List<Product> products;
  final ProductsBloc productsBloc;

  const ProductsMobileWidget({
    Key? key,
    required this.products,
    required this.productsBloc,
  }) : super(key: key);

  @override
  _ProductsMobileWidgetState createState() => _ProductsMobileWidgetState();
}

class _ProductsMobileWidgetState extends State<ProductsMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product listing"),
        actions: [
          filterButton(),
          IconButton(
            onPressed: () async {
              await AutoRouter.of(context)
                  .push(AddProduct(isUrlRedirection: false));
              widget.productsBloc.getProducts();
            },
            icon: const Icon(Icons.add),
            tooltip: "Add Product",
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: widget.products.length,
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemBuilder: itemBuilder),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    var product = widget.products[index];
    return Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title("Name:   ", product.name),
                title(
                    "Launch Date:   ",
                    product.launchedAt
                            .tryParse("yyyy-MM-dd")
                            ?.getFormatedString("dd MMM, yyyy") ??
                        ''),
                title("Launched Site:   ", product.launchedSite),
                Row(
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
                )
              ],
            ),
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
                    widget.productsBloc.getProducts();
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
                    widget.productsBloc.deleteProduct(product.id, context);
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

  Widget title(String title, String value) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
          Expanded(child: Text(value))
        ],
      );

  Widget filterButton() => PopupMenuButton<FilterType>(
      child: Icon(Icons.sort_rounded),
      onSelected: (filterType) {
        widget.productsBloc.currentFilterType = filterType;
        widget.productsBloc.sort(filterType);
      },
      itemBuilder: (context) {
        return [
          getMenu(FilterType.sortByName, "Sort by name"),
          getMenu(FilterType.sortByLaunchdate, "Sort by launch date"),
          getMenu(FilterType.sortByLaunchsite, "Sort by launch site"),
          getMenu(FilterType.sortByRatings, "Sort by ratings")
        ];
      });

  PopupMenuItem<FilterType> getMenu(FilterType option, String title) =>
      PopupMenuItem<FilterType>(
        value: option,
        height: 30,
        child: Text(
          title,
          style: TextStyle(
            color: widget.productsBloc.currentFilterType == option
                ? Theme.of(context).primaryColor
                : Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}

enum FilterType {
  sortByName,
  sortByRatings,
  sortByLaunchdate,
  sortByLaunchsite,
}
