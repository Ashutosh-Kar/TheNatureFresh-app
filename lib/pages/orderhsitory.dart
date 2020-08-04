import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mushroomm/models/UserRepository.dart';
import 'package:mushroomm/models/order.dart';
import 'package:provider/provider.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    var _user = Provider.of<UserRepository>(context);
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back,
              size: 28,
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
          title: Text('Order History'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection('orders')
                  .where('user_id', isEqualTo: _user.firebaseuser.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Order> orders = List<Order>();
                  snapshot.data.documents.forEach((DocumentSnapshot item) {
                    orders.add(Order.fromJson(item.data));
                  });

                  print(jsonEncode(orders));
                  return ListView.builder(
                    reverse: false,
                    scrollDirection: Axis.vertical,
                    itemCount: orders.length,
                    itemBuilder: (context, index) =>
                        OrderCard(order: orders[orders.length - index - 1]),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ));
  }
}

class OrderCard extends StatelessWidget {
  OrderCard({this.order});

  final Order order;

  String items;


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Order ID: ${order.orderid}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8),
                Text(
                  'ITEMS',
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: 4,
                ),
                ...order.cart.products.map<Text>(
                  (product) => Text(
                    '${product.qty_purchased} x ${product.item_name}',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'ORDERED ON',
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  order.order_day,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // MaterialButton(
                //   // padding: EdgeInsets.symmetric(horizontal:15, vertical:12),
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(15)),
                //   color: Colors.red,
                //   onPressed: () {
                //     print(
                //         "do backedn to repeat order adn transfer to chkout page");
                //     //OR, can navigate to login page and ask for login
                //     // credentials and then allow user to enter.
                //   },
                //   child: Text(
                //     'Repeat',
                //     style: TextStyle(color: Colors.white, fontSize: 18),
                //   ),
                // ),
                Text(
                  'COD',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade400),
                ),
                Text(
                  '${order.orderStatus} ',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  order.total.toString(),
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
