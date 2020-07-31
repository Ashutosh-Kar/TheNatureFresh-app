import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCardPopular extends StatelessWidget {
  CustomCardPopular({@required this.m_image,@required this.m_price1});
  final String m_image;
  final String m_price1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          height: 180,
          width: 110,
          child:Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 100,
                  width: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(m_image),//TODO: Place original image
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(m_price1,
                          style: TextStyle(
                            fontSize: 8,
                          ),),
                      CustomGreenButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCardCategories extends StatelessWidget {
  CustomCardCategories({@required this.color1, @required this.text1});
  final Color color1;
  final String text1;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: color1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: 105,
        width: 105,
        child: Column(
          children: <Widget>[
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('images/mush1.jpeg')),
              ),
            ),
            Text(text1, style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
          ],
        ),
      ),
    );
  }
}

class GridCardRecommend extends StatefulWidget {
  @override
  _GridCardRecommendState createState() => _GridCardRecommendState();
}

class _GridCardRecommendState extends State<GridCardRecommend> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          height: 200,
          width: 150,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('images/mush1.jpeg'),//TODO: Place original image
                      )
                  ),
                ),
                Text('Oyester Mushroom',style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Rs 40/120g'),
                      CustomGreenButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomGreenButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //TODO: increase item count in cart
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(0.0),
            topLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(0.0),
          ),
        ),
        height: 20,
        width: 32,
        child: Icon(Icons.shopping_basket,
          size: 15,color: Colors.white,),
      ),);
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
