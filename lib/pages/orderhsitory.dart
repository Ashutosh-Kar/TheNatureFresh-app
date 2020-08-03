import 'package:flutter/material.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body:ListView(

      )
    );
  }
}
