import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mushroomm/info/customwidgets.dart';
import 'package:mushroomm/models/UserRepository.dart';
import 'package:mushroomm/models/cart.dart';
import 'package:mushroomm/models/product.dart';
import 'package:mushroomm/pages/Editinfo.dart';
import 'package:mushroomm/pages/cartpage.dart';
import 'package:mushroomm/pages/loginpage.dart';
import 'package:mushroomm/pages/onBoarding.dart';
import 'package:mushroomm/pages/orderhsitory.dart';
import 'package:provider/provider.dart';

class Mush extends StatefulWidget {
  static String id = 'first_page';

  @override
  _MushState createState() => _MushState();
}

class _MushState extends State<Mush> {
  List<Product> products;
  int itemCount;
  bool load = true;

  Future<void> getProducts() async {
    var snapshots =
        await Firestore.instance.collection('products').getDocuments();
    setState(() {
      snapshots.documents.forEach((element) {
        products.add(Product.fromJson(element.data));
      });
      load = false;
    });
  }

  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    products = List<Product>();
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build method called');
    //The line of code that you think you can delete but you can't
    itemCount = context.watch<Cart>().countItem;
    return Scaffold(
      key: key,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          child: Icon(
            Icons.clear_all,
            size: 28,
          ),
          onTap: () => key.currentState.openDrawer(),
        ),
        actions: <Widget>[
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.location_on,
                size: 28,
              ),
            ),
            onTap: () {
              context.read<UserRepository>().signOut();
            },
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.shopping_basket,
                      size: 28,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, CartPage.id);
                    },
                  ),
                  Positioned(
                      top: 3,
                      right: 5,
                      child: Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                          child: Center(
                              child: Text(
                            itemCount.toString() ?? '0',
                            style: TextStyle(color: Colors.white),
                          ))))
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        elevation: 0,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('images/logo1.png'),
                  ),
                ],
              ),
            ),
            Text(
              context
                  .watch<UserRepository>()
                  .firebaseuser
                  .displayName
                  .toString(),
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              context.watch<UserRepository>().firebaseuser.email.toString() ??
                  '',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Order History'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OrderHistory())),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit User Info'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => EditInfo())),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
             ListTile(
              leading: Icon(Icons.screen_share),
              title: Text('Splash'),
              onTap: () {
               
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => OnBoarding()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  hintText: 'Search fresh mushrooms, seeds & more',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onChanged: (value) {
                  print('Text Input');
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.topLeft,
              child: Text(
                'Our Items',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
              child: load
                  ? CircularProgressIndicator()
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 8),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CardPopular(product: products[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
// Container(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: CustomScrollView(
//             slivers: <Widget>[
//               SliverList(
//                 delegate: SliverChildListDelegate(
//                   [
//                     TextField(
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(
//                             Icons.search, color: Colors.grey.shade500),
//                         filled: true,
//                         fillColor: Colors.grey.shade300,
//                         hintText: 'Search fresh mushrooms, seeds & more',
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               style: BorderStyle.none),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                       onChanged: (value) {
//                         print('Text Input');
//                       },),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
//                       child: Text('Popular Searches', style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 30,
//                       ),
//                       ),
//                     ),
//                     SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                             children: [
//                               ...products.map<Widget>((product) =>
//                                   CardPopular(product: product,))
//                             ]
//                         )
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
//                       child: Text('Categories', style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 30,
//                       ),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         GestureDetector(
//                           child: CustomCardCategories(
//                             color1: Colors.green.shade50,
//                             text1: 'Mushroom',),
//                           onTap: () {
//                             print('Mushroom');
//                             Navigator.pushNamed(context, CategoryPage.id);
//                           },),
//                         GestureDetector(
//                           child: CustomCardCategories(
//                             color1: Colors.pink.shade50,
//                             text1: 'Spawn',),
//                           onTap: () {
//                             print('spawn');
//                             print('Mushroom');
//                             Navigator.pushNamed(context, CategoryPage.id);
//                           },),
//                         GestureDetector(
//                           child: CustomCardCategories(
//                             color1: Colors.orange.shade50,
//                             text1: 'Bags',),
//                           onTap: () {
//                             print('Bags');
//                             print('Mushroom');
//                             Navigator.pushNamed(context, CategoryPage.id);
//                           },),
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 25.0, bottom: 20.0),
//                       child: Text('Recommended for you', style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 30,
//                       ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SliverGrid(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                 ),
//                 delegate: SliverChildBuilderDelegate((BuildContext context,
//                     int index) {
//                   return GridCardRecommend();
//                 }, childCount: 10,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),

class CardPopular extends StatelessWidget {
  final Product product;

  const CardPopular({
    this.product,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: product,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CustomCardPopular(
            mimage: product.image_url,
            mprice1: 'Rs ${product.price}/120g',
            onTap: () => context.read<Cart>().addProduct(product: product),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            product.item_name.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
