import 'package:flutter/material.dart';
import 'package:mushroomm/info/customwidgets.dart';
import 'package:mushroomm/models/UserRepository.dart';
import 'package:mushroomm/models/cart.dart';
import 'package:mushroomm/models/product.dart';
import 'package:mushroomm/pages/paymentpage.dart';
import 'package:provider/provider.dart';

import 'categoriespage.dart';

class CartPage extends StatefulWidget {
  static String id = 'cart_page';

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
                          Text(
                            'Deliver to ' +
                                    context
                                        .watch<UserRepository>()
                                        .firebaseuser
                                        .email ??
                                '',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height:8),
                          Text('A-13 Noida, Delhi-114672', style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
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

  Widget createTable({List<Product> products}) {
    List<TableRow> rows = [];
    products.forEach((product) =>
    {
      rows.add(TableRow(children: [
        CartItems(
          product: product,
          onTap: () => {},
        ),
      ]))
    });

    return Table(children: rows);
  }

  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);
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
                    ),),
                    GestureDetector(
                      child: Icon(Icons.shopping_basket),
                      onTap: () {
                        Navigator.pushNamed(context, PaymentPage.id);
                      },),
                  ],
                ),
              ),
              userDetails(),
              createTable(products: cart.products),
              DeliveryCard(),
            ],
          ),
        ),
      ),
    );
  }
}

//Layout of widget for each cart item
class CartItems extends StatelessWidget {
  Product product;
  Function onTap;

  CartItems({@required this.product, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: product,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 20.0, left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                VarietyImageCard(imgg: product.image_url),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(product.item_name, style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                    AddItemIconBar(),
                  ],
                ),
              ],
            ),
            Text('Rs ${product.price}'),
            //Original price to be calculated and produced here
          ],
        ),
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
    double total = 0;
    Cart cart = Provider.of<Cart>(context);
    cart.products.forEach((element) {
      total += element.price * element.qty_purchased;
    });
    print(total);

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
                  Text('$total', style: TextStyle(
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

