import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;
import 'package:outline_material_icons/outline_material_icons.dart';

var a;
var b, c, d, e, f, g, h; // initalize using controleler or these data

class EditInfo extends StatefulWidget {
  @override
  _EditInfoState createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            size: 28,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
        title: Text('Edit Info'),
        centerTitle: true,        
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  b = value; //Save firstname
                },
              ),
              CustomTextField(
                iconfield: Icons.perm_identity,
                hinttext: 'Middle Name',
                onsaved: (value) {
                  c = value;
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return null;
                  }
                  return null;
                },
              ),
              CustomTextField(
                  iconfield: Icons.perm_identity,
                  hinttext: 'Last Name',
                  onsaved: (value) {
                    d = value;
                    //store value
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter your last name';
                    }
                    return null;
                  }),
              CustomTextField(
                  iconfield: OMIcons.home,
                  hinttext: 'Full Address',
                  onsaved: (value) {
                    e = value;
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
                          iconfield: OMIcons.landscape,
                          hinttext: 'Landmark',
                          onsaved: (value) {
                            f = value;
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
                        iconfield: OMIcons.locationOn,
                        hinttext: 'Pincode',
                        onsaved: (value) {
                          g = value;
                        },
                        validator: (String value) {
                          if (value.isEmpty || !validator.isNumeric(value)) {
                            return 'Enter proper pin code';
                          }
                          return null;
                        }),
                  ),
                ],
              ),
              CustomTextField(
                  iconfield: OMIcons.phone,
                  hinttext: 'Mobile Number',
                  onsaved: (value) {
                    h = value;
                  },
                  validator: (String value) {
                    if (value.isEmpty || !validator.isNumeric(value)) {
                      return 'Enter valid mobile number';
                    }
                    return null;
                  }),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                child: MaterialButton(
                  minWidth: 250,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Color.fromRGBO(136, 172, 104, 1),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      print("do backedn to update data");
                      //OR, can navigate to login page and ask for login
                      // credentials and then allow user to enter.
                    }
                  },
                  child: Text('Update',
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {@required this.iconfield,
      @required this.hinttext,
      @required this.onsaved,
      @required this.validator});
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
        validator: widget.validator,
        onSaved: widget.onsaved,
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.iconfield,
            color: Colors.black,
            size: 30,
          ),
          filled: true,
          fillColor: Colors.white,
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
