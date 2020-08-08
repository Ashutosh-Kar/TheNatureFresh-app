import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mushroomm/pages/loginwrapper.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            image: Center(child: SvgPicture.asset('images/one.svg',height: 200,width: 200,)),
            titleWidget: Text('Select Item',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
            bodyWidget: Text('Order Mushroom and get delivery in the fastest time available in town',style: TextStyle(color: Colors.grey[600]),textAlign: TextAlign.center,),
            ),
          PageViewModel(
            image: Center(child: SvgPicture.asset('images/two.svg',height: 200,width: 200,)),
            titleWidget: Text('Enter Your Address',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
            bodyWidget: Text('Order Mushroom and get delivery in the fastest time available in town',style: TextStyle(color: Colors.grey[600]),textAlign: TextAlign.center,),
            ),
          PageViewModel(
            image: Center(child: SvgPicture.asset('images/three.svg',height: 200,width: 200,)),
            titleWidget: Text('Delivery To Your Home',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
            bodyWidget: Text('Order Mushroom and get delivery in the fastest time available in town',style: TextStyle(color: Colors.grey[600]),textAlign: TextAlign.center,),
            ),
          
        ],
        onDone: () {
          // When done button is press
          Navigator.pushNamed(context, LoginWrapper.id);
        },
        onSkip: () {
          // You can also override onSkip callback
          Navigator.pushNamed(context, LoginWrapper.id);
        },
        showSkipButton: true,
        skip: const Icon(Icons.skip_next),
        next: const Icon(Icons.arrow_right),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Colors.redAccent,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}
