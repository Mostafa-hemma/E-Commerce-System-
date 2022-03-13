import 'package:flutter/material.dart';
import 'package:shop_app/models/Cart.dart';
import 'components/Placeorder.dart';
import 'components/body.dart';

class CheckOut extends StatelessWidget {
  static String routeName = "/checkout";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: Placeorder(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Checkout",
            style: TextStyle(color: Colors.black),
          ),
          /*Text(
            "${demoCarts.length} items",
            style: Theme.of(context).textTheme.caption,
          ),*/
        ],
      ),
    );
  }
}
