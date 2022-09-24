import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interview/dbhelper.dart';
import 'package:interview/main.dart';
import 'package:interview/models/usermodel.dart';
import 'package:interview/screens/dashboardscreen.dart';
import 'package:interview/screens/loginscreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sqflite/sqlite_api.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernamecontroller = TextEditingController();
  final _key = GlobalKey<FormState>();
  Random random = new Random();
  late DataBase handler;

  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController usernamenamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController cpasswordcontroller = TextEditingController();
  @override
  void initState() {
    handler = DataBase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFF0000),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0.r),
        child: Form(
          key: _key,
          child: Column(children: [
            SizedBox(
              height: 15.sm,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter first name";
                } else {
                  return null;
                }
              },
              controller: firstnamecontroller,
              cursorColor: Colors.grey,
              decoration: InputDecoration(hintText: "First name"),
            ),
            SizedBox(
              height: 15.sm,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter last name";
                } else {
                  return null;
                }
              },
              controller: lastnamecontroller,
              cursorColor: Colors.grey,
              decoration: InputDecoration(hintText: "Last name"),
            ),
            SizedBox(
              height: 15.sm,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter Username";
                } else {
                  return null;
                }
              },
              controller: usernamecontroller,
              cursorColor: Colors.grey,
              decoration: InputDecoration(hintText: "Username"),
            ),
            SizedBox(
              height: 15.sm,
            ),
            AppTextField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter Email";
                } else {
                  return null;
                }
              },
              controller: emailcontroller,
              textFieldType: TextFieldType.EMAIL,
              decoration: InputDecoration(hintText: "Email ID"),
            ),
            SizedBox(
              height: 15.sm,
            ),
            AppTextField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "length shoud be grether than 6 ";
                } else {
                  return null;
                }
              },
              controller: passwordcontroller,
              textFieldType: TextFieldType.PASSWORD,
              decoration: InputDecoration(hintText: "Password"),
            ),
            SizedBox(
              height: 15.sm,
            ),
            AppTextField(
              validator: (value) {
                if (value != passwordcontroller.text) {
                  return "password not match";
                } else {
                  return null;
                }
              },
              controller: cpasswordcontroller,
              textFieldType: TextFieldType.PASSWORD,
              decoration: InputDecoration(hintText: "Confirm Password"),
            ),
            SizedBox(
              height: 15.sm,
            ),
            SizedBox(
              height: 15.sm,
            ),
            InkWell(
              onTap: () async {
                if (_key.currentState!.validate()) {
                  handler
                      .insertDog(Users(
                          id: random.nextInt(99),
                          firstname: firstnamecontroller.text,
                          lastname: lastnamecontroller.text,
                          username: usernamecontroller.text,
                          email: emailcontroller.text,
                          password: passwordcontroller.text,
                          confirmationpassword: cpasswordcontroller.text))
                      .whenComplete(() {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  });
                }
              },
              child: Container(
                height: 45.sm,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xffFF0000),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    "Create an account",
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline3!
                        .copyWith(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.sm,
            ),
            Center(
              child: Text(
                "Login",
                style: Theme.of(context)
                    .primaryTextTheme
                    .bodyLarge!
                    .copyWith(fontSize: 20.sp, color: Colors.white),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
