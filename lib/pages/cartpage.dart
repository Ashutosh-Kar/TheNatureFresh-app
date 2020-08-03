import 'package:flutter/material.dart';
import 'package:mushroomm/info/customwidgets.dart';
import 'package:mushroomm/models/UserRepository.dart';
import 'package:mushroomm/models/cart.dart';
import 'package:mushroomm/models/orderdetails.dart';
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
  Widget userDetails() {
    return Container(
      // height: 100,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromRGBO(136, 172, 104, 1),
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
                            'Deliver to\n' +
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
                          SizedBox(height: 8),
                          Text(
                            'A-13 Noida, Delhi-114672',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text('Change',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16
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
    products.forEach((product) => {
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Cart',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        // actions: <Widget>[
        //   Padding(
        //     padding: const EdgeInsets.only(right: 22.0),
        //     child: GestureDetector(
        //       child: Icon(Icons.shopping_basket),
        //       onTap: () {
        //         Navigator.pushNamed(context, PaymentPage.id);
        //       },
        //     ),
        //   ),
        // ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            userDetails(),
            createTable(products: cart.products),
            DeliveryCard(),
            MaterialButton(
              height: 45,
              child: Text('Checkout',style: TextStyle(fontSize: 22,color: Colors.white),),
              minWidth: 300,
              color: Color.fromRGBO(136, 172, 104, 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              onPressed: () {
                Navigator.pushNamed(context, PaymentPage.id);
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
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
          top: 20.0,
          bottom: 20.0,
        ),
        child: ListTile(
          leading: VarietyImageCard(imgg: product.image_url),
          title: Text(product.item_name,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          subtitle: AddItemIconBar(),
          trailing: Text('Rs ${product.price}'),
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
    OrderDetails _orderDetails = Provider.of<OrderDetails>(context);
    double total =
        _orderDetails.packing_charges + _orderDetails.delivery_charges;
    Cart cart = Provider.of<Cart>(context);
    cart.products.forEach((element) {
      total += element.price * element.qty_purchased;
    });
    _orderDetails
      ..total = total
      ..sgst = 0.035 * total
      ..cgst = 0.035 * total
      ..gst = 0.07 * total;

    print(total);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
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
                  Text('Rs ${_orderDetails.delivery_charges}'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Packing Charges'),
                  Text("Rs ${_orderDetails.packing_charges}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('GST'),
                  Text('Rs ${_orderDetails.gst.toStringAsFixed(2)}'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text('$total',
                      style: TextStyle(
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
