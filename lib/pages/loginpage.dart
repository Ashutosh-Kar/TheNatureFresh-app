import 'package:flutter/material.dart';
import 'package:mushroomm/pages/firstpage.dart';
import 'package:mushroomm/pages/signuppage.dart';

class LoginPage extends StatefulWidget {
  static String id= 'login_page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // final _auth=FirebaseAuth.instance;
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
                padding: const EdgeInsets.only(top:10.0,left: 80,right: 80),
                child: RaisedButton(
                  color: Colors.green,
                  onPressed: () {
                    Navigator.pushNamed(context, Mush.id);//For the time being logs in anyway :)
                  },
                  child: Text('LOGIN',style: TextStyle(
                      color: Colors.white
                  ),),
                )
            ),
            Padding(
                padding: const EdgeInsets.only(top:10.0,left: 70,right: 70),
                child: RaisedButton(
                  color: Colors.green,
                  onPressed: () {
                    //send OTP to registered mail
                    verifyOTP(context);
                  },
                  child: Text('LOGIN via OTP',style: TextStyle(
                      color: Colors.white
                  ),),
                )
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
              child: Column(
                children: <Widget>[
                  Text('Don\'t have an account?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                  RaisedButton(
                    color: Colors.green,
                    onPressed: (){
                       Navigator.pushNamed(context, SignupPage.id);
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

void verifyOTP(BuildContext context){
  var alert= AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))
    ),
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
            Text('OTP verification',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),),
            Text('Enter OTP from registered mail',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_open, color: Colors.grey.shade500),
                filled: true,
                fillColor: Colors.green.shade50,
                hintText: 'OTP',
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
                //get the value entered by user as OTP
              },),
            RaisedButton(
              color: Colors.green,
              onPressed: (){
                //if OTP verification successful then:
                Navigator.pushNamed(context, Mush.id);
              },
              child: Text('LOGIN',style: TextStyle(
                  color: Colors.white
              )),
            ),
          ],
        )),
  );
  showDialog(context: context,
      builder: (BuildContext context)
      {
        return alert;
      }
  );
}
