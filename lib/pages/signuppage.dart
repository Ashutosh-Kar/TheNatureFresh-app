import 'package:flutter/material.dart';
import 'package:mushroomm/models/UserRepository.dart';
import 'package:mushroomm/pages/detailpage.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  static String id = 'signup_page';

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _scaffoldState = GlobalKey<ScaffoldState>();

  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    var _userRepository = Provider.of<UserRepository>(context);

    return Scaffold(
        key: _scaffoldState,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/loginbg.png'),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.14),
                      Image.asset(
                        'images/logo1.png',
                        height: 150,
                      ),
                      Text(
                        'The Nature Fresh',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: Icon(OMIcons.mail, color: Colors.white),
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                  ),
                  SizedBox(height: 22),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.dialpad, color: Colors.white),
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'There you go!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20,),
                       MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minWidth: 250,
                    color: Color.fromRGBO(101, 151, 57, 1),
                          onPressed: () async {
                            print('clik');
                            if (await _userRepository.signUp(
                                email: email, password: password)) {
                              Navigator.pushNamed(context, DetailPage.id);
                            } else {
                              _scaffoldState.currentState.showSnackBar(SnackBar(
                                content:
                                    Text("Invalid Email or Password format",
                                    style: TextStyle(color: Colors.white,),
                              )));
                            }
                          },
                          child: Text('SIGN UP',
                              style: TextStyle(color: Colors.white, fontSize: 22)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
