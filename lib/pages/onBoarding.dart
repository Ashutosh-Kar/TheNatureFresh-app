import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            image: SvgPicture.asset('images/one.svg',height: 100,),
            title: 'asd',
            body: 'sdasdfdsfdsfd',
            footer: RaisedButton.icon(onPressed: (){}, icon: Icon(Icons.ac_unit), label: Text('ad'))
          ),
          PageViewModel(
            image: SvgPicture.asset('images/one.svg'),
            title: 'asd',
            body: 'sdasdfdsfdsfd',
            footer: RaisedButton.icon(onPressed: (){}, icon: Icon(Icons.ac_unit), label: Text('ad'))
          ),
          PageViewModel(
            image: SvgPicture.asset('images/one.svg'),
            title: 'asd',
            body: 'sdasdfdsfdsfd',
            footer: RaisedButton.icon(onPressed: (){}, icon: Icon(Icons.ac_unit), label: Text('ad'))
          ),
          PageViewModel(
            image: SvgPicture.asset('images/one.svg'),
            title: 'asd',
            body: 'sdasdfdsfdsfd',
            footer: RaisedButton.icon(onPressed: (){}, icon: Icon(Icons.ac_unit), label: Text('ad'))
          ),
          
        ],
        onDone: () {
          // When done button is press
        },
        onSkip: () {
          // You can also override onSkip callback
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
