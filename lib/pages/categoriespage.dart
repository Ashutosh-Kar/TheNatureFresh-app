import 'package:flutter/cupertino.dart';
import 'package:mushroomm/info/datamodel.dart';
import 'package:flutter/material.dart';
import 'paymentpage.dart';

class CategoryPage extends StatefulWidget {
  static String id='category_mushroom';
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = listdata;
    List<Widget> listItems = [];
    responseList.forEach((indx) {
      listItems.add(Container(
          height: 120,
          child: Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  VarietyImageCard(imgg: indx["image"]),
                  Padding(
                    padding: const EdgeInsets.only(top:10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          indx["name"],
                          style: TextStyle(fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),),
                        Row(
                          //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              indx["quantity"],
                              style: const TextStyle(fontSize: 17, color: Colors.grey),
                            ),
                            Text('-'),
                            Text(
                              indx["price"],
                              style: const TextStyle(fontSize: 17, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //   RaisedButton(onPressed: (){print('pressed');}),
                  AddItemIconBar(),
                ],
              )
          )));
    });
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffd5f7c4),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
              child: Icon(Icons.arrow_back_ios,color: Colors.black),
          onTap: (){
                Navigator.pop(context);
          },),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, PaymentPage.id); //for time being
                //TODO:This will navigate to Cart page once it's made.
              },
                child: Icon(Icons.shopping_basket,color: Colors.black,)),
          ),
        ],
      ),
      body:
      SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          height: size.height*(0.2*itemsData.length),
          color: Colors.grey.shade300,
          child: Column(
            children: <Widget>[
              Container(
                height: 190,
                child: Padding(
                  padding: const EdgeInsets.only(bottom:15.0),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(0.0),
                          topLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(50.0),
                          bottomLeft: Radius.circular(50.0),
                        ),
                        color: Color(0xffd5f7c4),
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(
                              'https://secureservercdn.net/50.62.174.113/p7w.5c4.myftpupload.com/wp-content/uploads/revslider/herbal/coonfresh-gallery-slide-1.png'),),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left:20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top:5.0, bottom: 10.0),
                          child: Text('Mushrooms', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                          ),
                        ),
                        Text('Varieties',textAlign: TextAlign.left, style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade700,
                        ),),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    physics : ScrollPhysics(),
                    itemCount: itemsData.length,
                    // physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return itemsData[index];
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VarietyImageCard extends StatelessWidget {
  VarietyImageCard({@required this.imgg});
  final String imgg;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: 70,
        width: 110,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(imgg),
              )
          ),
        ),
      ),
    );
  }
}

class AddItemIconBar extends StatefulWidget {
  @override
  _AddItemIconBarState createState() => _AddItemIconBarState();
}

class _AddItemIconBarState extends State<AddItemIconBar> {
  int itemcount=0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 80,
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              setState(() {
                if(itemcount>0)
                  itemcount--;
                else
                  itemcount=0;
              });
            },
            onLongPress: (){
              setState(() {
                itemcount=0;
              });
            },
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Icon(Icons.maximize,color: Colors.white,size: 20,),
              ),
            ),
          ),
          Container(
            height: 24,
            width: 24,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(child: Text(itemcount.toString())),
            ),),
          GestureDetector(
            onTap: (){
              setState(() {
                itemcount++;
              });
            },
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(Icons.add,color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }
}
