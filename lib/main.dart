import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mushroomm/info/customwidgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Mush(),
    );
  }
}
class Mush extends StatefulWidget {
  @override
  _MushState createState() => _MushState();
}

class _MushState extends State<Mush> {
  @override
  Widget build(BuildContext context) {
    //final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        leading: Icon(Icons.clear_all),
        actions: <Widget>[
          GestureDetector(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.location_on),
          ),
          onTap: (){
            //TODO: navigate to location page
          },),
          GestureDetector(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.shopping_basket),
          ),
          onTap: (){
            //TODO:navigate to shopping cart
          },),
        ],
      ),
      body:
      Container(
        color: Colors.grey.shade300,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search fresh mushrooms, seeds & more',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value){
                          print('Text Input');
                        },),
                    Padding(
                      padding: const EdgeInsets.only(top:20.0, bottom: 20.0),
                      child: Text('Popular Searches', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                CustomCardPopular(
                                  m_image: 'https://secureservercdn.net/50.62.174.113/p7w.5c4.myftpupload.com/wp-content/uploads/revslider/herbal/coonfresh-gallery-slide-1.png',
                                m_price1: 'Rs 40/120g',
                                ),
                                Text('Mushroom Spawn',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                CustomCardPopular(m_image: 'https://secureservercdn.net/50.62.174.113/p7w.5c4.myftpupload.com/wp-content/uploads/revslider/herbal/coonfresh-gallery-slide-1.png',
                                m_price1: 'Rs 50/100g',),
                                Text('Mushroom Spawn',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                CustomCardPopular(m_image: 'https://secureservercdn.net/50.62.174.113/p7w.5c4.myftpupload.com/wp-content/uploads/revslider/herbal/coonfresh-gallery-slide-1.png',
                                  m_price1: 'Rs 50/100g',
                                ),
                                Text('Mushroom Spawn',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                CustomCardPopular(m_image: 'https://secureservercdn.net/50.62.174.113/p7w.5c4.myftpupload.com/wp-content/uploads/revslider/herbal/coonfresh-gallery-slide-1.png',
                                  m_price1: 'Rs 40/100g',
                                ),
                                Text('Mushroom Spawn',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),),
                              ],
                            ),
                          ]
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:20.0, bottom: 20.0),
                      child: Text('Categories', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          child: CustomCardCategories(
                              color1: Colors.green.shade50,
                          text1: 'Mushroom',),
                        onTap: (){
                          print('Mushroom');
                        },),
                        GestureDetector(
                          child: CustomCardCategories(
                              color1: Colors.pink.shade50,
                            text1: 'Spawn',),
                          onTap: (){
                            print('spawn');
                          },),
                        GestureDetector(
                          child: CustomCardCategories(
                              color1: Colors.orange.shade50,
                            text1: 'Bags',),
                          onTap: (){
                            print('Bags');
                          },),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:25.0, bottom: 20.0),
                      child: Text('Recommended for you', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                ),
                delegate: SliverChildBuilderDelegate((BuildContext context,int index){
                  return GridCardRecommend();
                }, childCount: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


