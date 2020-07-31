import 'package:flutter/material.dart';
import 'package:mushroomm/pages/paymentpage.dart';
import 'categoriespage.dart';
import 'package:mushroomm/info/customwidgets.dart';

class CartPage extends StatefulWidget {
  static String id='cart_page';
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Widget userDetails(){
    return Container(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(bottom:10.0),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left:15.0,right: 15.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.green,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Deliver to Roshan Kumar', style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(height:15),
                          Text('A-13 Noida, Delhi-114672', style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){

                      },
                      child: Text('Change',style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget createTable() {
    List<TableRow> rows = [];
    for (int i = 0; i < 4; ++i) {
      rows.add(TableRow(children: [
        CartItems(),
      ]));
    }
    return Table(children: rows);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body:
      SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          color: Colors.grey.shade300,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:35.0,left: 10,right: 14,bottom:20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(Icons.arrow_back_ios),
                      onTap: (){
                          Navigator.pop(context);
                      },
                    ),
                    Text('Cart',style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ) ,),
                    GestureDetector(
                      child: Icon(Icons.shopping_basket),
                      onTap: (){
                          Navigator.pushNamed(context, PaymentPage.id);
                      },),
                  ],
                ),
              ),
              userDetails(),
              createTable(),
              DeliveryCard(),
            ],
          ),
        ),
      ),
    );
  }
}

//Layout of widget for each cart item
class CartItems extends StatefulWidget {
  @override
  _CartItemsState createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20.0,bottom: 20.0,left: 15,right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              VarietyImageCard(imgg: 'https://static.toiimg.com/thumb/74866653.cms?width=680&height=512&imgsize=222332'),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Mushroom Name',style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
                  AddItemIconBar(),
                ],
              ),
            ],
          ),
          Text('Rs 500'),//Original price to be calculated and produced here
        ],
      ),
    );
  }
}

//Layout for CartPage Payment details (total payment details to be passed here)
class DeliveryCard extends StatefulWidget {
  @override
  _DeliveryCardState createState() => _DeliveryCardState();
}

class _DeliveryCardState extends State<DeliveryCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Delivery Charges'),
                  Text('Rs 20'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Packing Charges'),
                  Text('Rs 20'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('GST'),
                  Text('Rs 20'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total',style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),),
                  Text('Rs 80',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

