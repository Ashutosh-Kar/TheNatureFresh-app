import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mushroomm/models/UserRepository.dart';
import 'package:mushroomm/pages/firstpage.dart';
import 'package:mushroomm/pages/loginpage.dart';
import 'package:provider/provider.dart';

class LoginWrapper extends StatelessWidget {
  static String id = "login_wrapper";

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('mushroom');
    bool setupComplete = box.get('initStatus');

    return Consumer<UserRepository>(
      builder: (context, user, child) {
        print(user.status);
        switch (user.status) {
          case Status.Uninitialized:
            return Container();
          case Status.Unauthenticated:
          case Status.Authenticating:
            return LoginPage();
          case Status.Authenticated:
            {
              var box = Hive.box('mushroom');
              user.fetchUserFromFirebase();
              bool initStatus = box.get('initStatus', defaultValue: false);
              print(initStatus);
              return Mush();
            }
          default:
            return Text('lol');
        }
      },
    );
  }
}
