import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';

import '../../../constants.dart';
import '../../../model/user_model.dart';
import '../../../size_config.dart';
import '../../sign_in/sign_in_screen.dart';

class AddressForm extends StatefulWidget {
  @override
  _AddresFormState createState() => _AddresFormState();
}

class _AddresFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String? firstname;
  String? secondname;
  String? mobileno;
  String? address;
  String? specialmark;
  bool visiblity = true;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildSecondNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildMobileFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildSpecialmarkFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          /*DefaultButton(
            text: "Save Address",
            press: () {
              setState(() {
                Flutter.toast;
              });

              /*if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                signup(email!, password!);
              }*/
            },
          ),*/
        ],
      ),
    );
  }

/*
  String? currentmail;
  //sign up function
  void signup(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                currentmail = postDetaisToFirestore() as String?,
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }


//passing data in textfeilds to database
  Future<String?> postDetaisToFirestore() async {
//calling firebase
    FirebaseFirestore firebasefirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

//calling ourusermoder
    Usermodel usermodel = Usermodel();
    usermodel.email = user?.email;
    usermodel.uid = user?.uid;
    usermodel.firstname = firstname;
    usermodel.secondname = secondname;

//send the data to database
    await firebasefirestore
        .collection('users')
        .doc(user!.uid)
        .set(usermodel.toMap());
    Fluttertoast.showToast(msg: "Account Created Successfully");

    Navigator.pushNamed(context, SignInScreen.routeName);
    return usermodel.email;
  }
*/
  TextFormField buildSpecialmarkFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => specialmark = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        specialmark = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kaddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Special Mark",
        hintText: "Enter Special mark For Your Address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.location_on),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        address = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kaddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your Address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.location_on),
      ),
    );
  }

  TextFormField buildMobileFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => mobileno = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMobileNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kMobileNullError);
          return "";
        } else if (!mobileValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidMobileError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Mobile Number",
        hintText: "Enter your Mobile Number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.phone),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => firstname = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your First Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        suffixIcon: Icon(Icons.person),
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildSecondNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => secondname = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Second Name",
        hintText: "Enter your Second Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        suffixIcon: Icon(Icons.person),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
