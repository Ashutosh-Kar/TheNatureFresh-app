import 'package:flutter/material.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
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
          child: ListView.builder(
            reverse: true,
            scrollDirection: Axis.vertical,
            itemCount: 10,
            itemBuilder: (context, index) => OrderCard(id: index),
          ),
        ));
  }
}

class OrderCard extends StatelessWidget {
  OrderCard({this.id});
  final id;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Order Id: $id',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 8),
                Text(
                  'ITEMS',
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  '1 x abcd, 2 x efgh',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                ),                
                SizedBox(height: 4),
                Text(
                  'ORDERED ON',
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  'Timesptamp',
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
                  'Deliverd ',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'RS 100',
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
