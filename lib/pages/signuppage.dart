import 'package:flutter/material.dart';
import 'package:mushroomm/models/UserRepository.dart';
import 'package:mushroomm/pages/firstpage.dart';
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
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  'https://img.freepik.com/free-photo/fresh-champignon-mushrooms-macro-shoot-close-up-white-sliced-champignon_174533-853.jpg?size=626&ext=jpg'),
            ),
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height:16),
                Text('The Nature Fresh',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),),
              ],
            ),
            SizedBox(height:60),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child:
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email, color: Colors.grey.shade500),
                  filled: true,
                  fillColor: Colors.green.shade50,
                  hintText: 'Email',
                  focusedBorder:OutlineInputBorder(
                    borderSide: BorderSide(
                        style: BorderStyle.solid),
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
                onChanged: (value){
                  email=value;
                },),
            ),
            SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child:
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_open, color: Colors.grey.shade500),
                  filled: true,
                  fillColor: Colors.green.shade50,
                  hintText: 'Password',
                  focusedBorder:OutlineInputBorder(
                    borderSide: BorderSide(
                        style: BorderStyle.solid),
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
                onChanged: (value){
                  password=value;
                },),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
              child: Column(
                children: <Widget>[
                  Text('There you go!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                  RaisedButton(
                    color: Colors.green,
                    onPressed: () async {
                      print('clik');
                      if (await _userRepository.signUp(
                          email: email, password: password)) {
                        Navigator.pushNamed(context, Mush.id);
                      }
                      else {
                        _scaffoldState.currentState.showSnackBar(SnackBar(
                          content: Text("Invalid Email or Password format"),));
                      }
                    },
                    child: Text('SIGN UP', style: TextStyle(
                        color: Colors.white
                    )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
