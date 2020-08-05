import 'package:flutter/material.dart';
import 'package:mushroomm/models/UserRepository.dart';
import 'package:mushroomm/pages/firstpage.dart';
import 'package:mushroomm/pages/signuppage.dart';
import 'package:provider/provider.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final _auth=FirebaseAuth.instance;
  final _scaffoldState = GlobalKey<ScaffoldState>();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    var _userRepository = Provider.of<UserRepository>(context);
    return Scaffold(
      key: _scaffoldState,
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        Container(
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
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.14),
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
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 80, right: 80),
                  child: MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minWidth: 250,
                    color: Color.fromRGBO(101, 151, 57, 1),
                    onPressed: () async {
                      if (await _userRepository.signInWithCredentials(
                          email: email, password: password)) {
                        await _userRepository.fetchUserFromFirebase();
                        Navigator.pushNamed(context,
                            Mush.id); //For the time being logs in anyway :)
                      } else {
                        _scaffoldState.currentState.showSnackBar(SnackBar(
                          content: Text("Invalid email or password",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                        ));
                      }
                    },
                    child: Text(
                      'LOGIN',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.10),
              // Padding(
              //     padding:
              //         const EdgeInsets.only(top: 10.0, left: 70, right: 70),
              //     child: RaisedButton(
              //       color: Colors.green,
              //       onPressed: () {
              //         //send OTP to registered mail
              //         verifyOTP(context);
              //       },
              //       child: Text(
              //         'LOGIN via OTP',
              //         style: TextStyle(color: Colors.white),
              //       ),
              //     )),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      minWidth: 80,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Color.fromRGBO(101, 151, 57, 1),
                      onPressed: () {
                        Navigator.pushNamed(context, SignupPage.id);
                      },
                      child: Text('SIGN UP',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

void verifyOTP(BuildContext context) {
  var alert = AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    content: Container(
        height: 300,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'OTP verification',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Text(
              'Enter OTP from registered mail',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_open, color: Colors.grey.shade500),
                filled: true,
                fillColor: Colors.green.shade50,
                hintText: 'OTP',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey.shade600,
                      width: 2,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                //get the value entered by user as OTP
              },
            ),
            RaisedButton(
              color: Colors.green,
              onPressed: () {
                //if OTP verification successful then:
                Navigator.pushNamed(context, Mush.id);
              },
              child: Text('LOGIN', style: TextStyle(color: Colors.white)),
            ),
          ],
        )),
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
