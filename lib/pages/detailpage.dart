import 'package:flutter/material.dart';
import 'package:mushroomm/models/UserRepository.dart';
import 'package:mushroomm/pages/firstpage.dart';
import 'package:mushroomm/pages/signuppage.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart' as validator;

InputDecoration getInputDecoration({IconData iconField, String hintText}) {
  return InputDecoration(
    prefixIcon: Icon(
      iconField,
      color: Colors.grey.shade500,
      size: 30,
    ),
    filled: true,
    fillColor: Colors.grey.shade200,
    hintText: hintText,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(style: BorderStyle.solid),
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: Colors.grey.shade400, width: 2, style: BorderStyle.solid),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

var a;
var b, c, d, e, f, g, h; // temporary

class DetailPage extends StatefulWidget {
  static String id = 'detail_page';

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String firstName;
  String lastName;
  String address;
  String landmark;
  String pincode;
  String phoneNumber;
  UserRepository _user;

  Future<void> getDetails() async {
    setState(() {
      var name = _user.firebaseuser.displayName?.split(" ");
      firstName = name[0];
      lastName = name.last;
      phoneNumber = _user.user.phone_number;
      var properAddress = _user.user.address;
      var addressArr = properAddress.split(RegExp(r",\s(landmark:|pincode:)"));
      address = addressArr[0] ?? '';
      landmark = addressArr[1] ?? '';
      pincode = addressArr[2] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<UserRepository>(context);
    if (_user.status == Status.Authenticated) {
      print("user not null");
      getDetails();
    }
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade300,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            size: 30,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.popAndPushNamed(context, SignupPage.id);
          },
        ),
        title: Text(
          'Enter Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  CustomTextField(
                    iconfield: Icons.perm_identity,
                    hinttext: 'First Name',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                    onsaved: (value) {
                      firstName = value;
                    },
                    initialText: firstName,
                  ),
                  CustomTextField(
                    iconfield: Icons.perm_identity,
                    hinttext: 'Last Name',
                    onsaved: (value) {
                      lastName = value;
                      //store value
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter your last name';
                      }
                      return null;
                    },
                    initialText: lastName,
                  ),
                  CustomTextField(
                      initialText: address,
                      iconfield: Icons.home,
                      hinttext: 'Full Address',
                      onsaved: (value) {
                        address = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter your full address';
                        }
                        return null;
                      }),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: CustomTextField(
                              initialText: landmark,
                              iconfield: Icons.account_balance,
                              hinttext: 'Landmark',
                              onsaved: (value) {
                                landmark = value;
                              },
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Enter landmark';
                                }
                                return null;
                              })),
                      SizedBox(width: 10),
                      Expanded(
                        child: CustomTextField(
                            initialText: pincode,
                            iconfield: Icons.location_on,
                            hinttext: 'Pincode',
                            onsaved: (value) {
                              pincode = value;
                            },
                            validator: (String value) {
                              if (value.isEmpty ||
                                  !validator.isNumeric(value)) {
                                return 'Enter proper pin code';
                              }
                              return null;
                            }),
                      ),
                    ],
                  ),
                  CustomTextField(
                      initialText: phoneNumber,
                      iconfield: Icons.phone,
                      hinttext: 'Mobile Number',
                      onsaved: (value) {
                        phoneNumber = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty || !validator.isNumeric(value)) {
                          return 'Enter valid mobile number';
                        }
                        return null;
                      }),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                    child: RaisedButton(
                      color: Colors.green,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          bool response = await _user.setDetails(
                              firstName: firstName,
                              lastName: lastName,
                              address: address,
                              landmark: landmark,
                              pincode: pincode,
                              phoneNumber: phoneNumber);
                          if (response == true) {
                            await _user.fetchUserFromFirebase();
                            Navigator.pushNamed(context, Mush.id);
                          } else {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text(
                                  "There was some error setting your details, please try again lager"),
                            ));
                            await _user.firebaseuser.delete();
                          }
                          //OR, can navigate to login page and ask for login
                          // credentials and then allow user to enter.
                        }
                      },
                      child: Text('ADD DETAILS',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  CustomTextField({@required this.iconfield,
    @required this.hinttext,
    @required this.onsaved,
    @required this.validator,
    @required this.initialText});

  final initialText;
  final IconData iconfield;
  final String hinttext;
  final Function onsaved;
  final Function validator;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: '${widget.initialText ?? ''}',
        validator: widget.validator,
        onChanged: widget.onsaved,
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.iconfield,
            color: Colors.grey.shade500,
            size: 30,
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
          hintText: widget.hinttext,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey.shade400,
                width: 2,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
