import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:product_management_demo/products/bloc/products_bloc.dart';
import 'package:product_management_demo/products/model/product.dart';
import 'package:product_management_demo/products/ui/mobile/products_mobile_widget.dart';
import 'package:product_management_demo/products/ui/web/products_web_gridview.dart';
import 'package:product_management_demo/products/ui/web/products_web_listview.dart';
import 'package:product_management_demo/utils/navigation_route_util.gr.dart';

class ProductsWebWidget extends StatefulWidget {
  final List<Product> products;
  final ProductsBloc productsBloc;

  const ProductsWebWidget({
    Key? key,
    required this.products,
    required this.productsBloc,
  }) : super(key: key);

  @override
  _ProductsWebWidgetState createState() => _ProductsWebWidgetState();
}

class _ProductsWebWidgetState extends State<ProductsWebWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Text(
                      "Product Listing",
                      style: TextStyle(
                          fontSize: 20, color: Theme.of(context).primaryColor),
                    ),
                    Spacer(),
                    toggleLayoutButton(),
                    SizedBox(width: 10),
                    filterButton(),
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: () async {
                        await AutoRouter.of(context)
                            .push(AddProduct(isUrlRedirection: false));
                        widget.productsBloc.getProducts();
                      },
                      icon: Icon(Icons.add,
                          color: Theme.of(context).primaryColor),
                      tooltip: "Add Product",
                    ),
                  ],
                )),
            Divider(),
            if (widget.products.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    'You haven\'t added any products yet.\nTap on \'+\' to add one!',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            Expanded(
              child: widget.productsBloc.isList
                  ? ProductWebListView(
                      products: widget.products,
                      productsBloc: widget.productsBloc,
                    )
                  : ProductWebGridView(
                      products: widget.products,
                      productsBloc: widget.productsBloc,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filterButton() => PopupMenuButton<FilterType>(
      child: Icon(Icons.sort_rounded, color: Theme.of(context).primaryColor),
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
          getMenu(FilterType.sortByRatings, "Sort by popularity (High to Low)")
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

  Widget toggleLayoutButton() => Transform.scale(
        scale: 0.75,
        child: ToggleButtons(
          children: [
            Icon(Icons.list),
            Icon(Icons.grid_on),
          ],
          isSelected: [widget.productsBloc.isList, !widget.productsBloc.isList],
          selectedColor: Theme.of(context).primaryColor,
          color: Colors.black,
          onPressed: (value) => widget.productsBloc.setLayoutType(value == 0),
        ),
      );
}
