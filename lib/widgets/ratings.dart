import 'package:flutter/material.dart';

class Ratings extends StatelessWidget {
  final double ratings;

  const Ratings({Key? key, required this.ratings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 4,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("$ratings"),
          Icon(
            Icons.star,
            size: 15,
            color: Colors.orangeAccent,
          ),
        ],
      ),
    );
  }
}
