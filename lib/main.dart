import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mushroomm/models/UserRepository.dart';
import 'package:mushroomm/models/cart.dart';
import 'package:mushroomm/models/orderdetails.dart';
import 'package:mushroomm/pages/categoriespage.dart';
import 'package:mushroomm/pages/detailpage.dart';
import 'package:mushroomm/pages/loginpage.dart';
import 'package:mushroomm/pages/loginwrapper.dart';
import 'package:mushroomm/pages/onBoarding.dart';
import 'package:mushroomm/pages/paymentpage.dart';
import 'package:mushroomm/pages/signuppage.dart';
import 'package:provider/provider.dart';

import 'pages/cartpage.dart';
import 'pages/firstpage.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('mushroom');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box('mushroom');
    var initStatus = box.get('initStatus', defaultValue: false);
    print(initStatus);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Cart>(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider<UserRepository>(
          create: (_) => UserRepository.instance(),
        ),
        InheritedProvider<OrderDetails>(
          create: (_) =>
              OrderDetails(packing_charges: 50.0, delivery_charges: 50.0),
        )
      ],
      child: MaterialApp(
        home: CustomSplash(
          imagePath: 'images/logo1.png',
          home: !initStatus ? OnBoarding() : LoginWrapper(),
          duration: 2500,
          logoSize: 200,
          backGroundColor: Colors.white,
          type: CustomSplashType.StaticDuration,
          animationEffect: 'zoom-in',
        ),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // initialRoute: LoginWrapper.id,
        routes: {
          LoginWrapper.id: (context) => LoginWrapper(),
          LoginPage.id: (context) => LoginPage(),
          SignupPage.id: (context) => SignupPage(),
          DetailPage.id: (context) => DetailPage(),
          Mush.id: (context) => Mush(),
          CategoryPage.id: (context) => CategoryPage(),
          PaymentPage.id: (context) => PaymentPage(),
          CartPage.id: (context) => CartPage(),
        },
      ),
    );
  }
}
