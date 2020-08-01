import 'package:flutter/material.dart';
import 'package:mushroomm/pages/loginpage.dart';

class SignupPage extends StatefulWidget {
  static String id= 'signup_page';
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(child:
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage('https://img.freepik.com/free-photo/fresh-champignon-mushrooms-macro-shoot-close-up-white-sliced-champignon_174533-853.jpg?size=626&ext=jpg'),
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
                    onPressed: (){
                      //TODO
                      Navigator.pushNamed(context, LoginPage.id );
                    },
                    child: Text('SIGN UP',style: TextStyle(
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
