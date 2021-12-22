import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:product_management_demo/products/bloc/products_bloc.dart';
import 'package:product_management_demo/products/model/product.dart';
import 'package:product_management_demo/utils/date_utils.dart';
import 'package:product_management_demo/utils/navigation_route_util.gr.dart';
import 'package:product_management_demo/widgets/ratings.dart';

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
        child: widget.products.isEmpty
            ? Center(
                child: Text(
                  'You haven\'t added any products yet.\nTap on \'+\' to add one!',
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                itemCount: widget.products.length,
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemBuilder: itemBuilder,
              ),
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
                  ],
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    await AutoRouter.of(context).push(
                        EditProduct(id: product.id, isUrlRedirection: false));
                    widget.productsBloc.getProducts();
                  },
                  icon: Icon(Icons.edit),
                ),
                SizedBox(
                  width: 4,
                ),
                IconButton(
                  onPressed: () {
                    widget.productsBloc.deleteProduct(product.id, context);
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
          getMenu(FilterType.sortByName, "Sort by name (A -> Z)"),
          getMenu(FilterType.sortByLaunchdate,
              "Sort by launch date (Recent first)"),
          getMenu(FilterType.sortByLaunchsite, "Sort by launch site (A -> Z)"),
          getMenu(FilterType.sortByRatings, "Sort by ratings (High to Low)")
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
