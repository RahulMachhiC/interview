import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interview/models/usermodel.dart';
import 'package:nb_utils/nb_utils.dart';

import '../dbhelper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late DataBase handler;

  @override
  void initState() {
    handler = DataBase();

    handler.retrievePlanets();
    super.initState();
  }

  final _key = GlobalKey<FormState>();
  TextEditingController passwordcontroller = TextEditingController();
  Random random = new Random();

  TextEditingController usernamecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(
        left: 20.r,
        right: 20.r,
      ),
      child: Form(
        key: _key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15.sm,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter username";
                } else {
                  return null;
                }
              },
              controller: usernamecontroller,
              cursorColor: Colors.grey,
              decoration: InputDecoration(hintText: "Email ID"),
            ),
            SizedBox(
              height: 15.sm,
            ),
            AppTextField(
              validator: (value) {
                if (value!.length < 6) {
                  return "Password should be 6 digit long";
                } else {
                  return null;
                }
              },
              controller: passwordcontroller,
              textFieldType: TextFieldType.PASSWORD,
              cursorColor: Colors.grey,
              decoration: InputDecoration(hintText: "Password"),
            ),
            SizedBox(
              height: 15.sm,
            ),
            InkWell(
              onTap: () {
                if (_key.currentState!.validate()) {
                  handler.loginuser(
                      context: context,
                      username: usernamecontroller.text,
                      password: passwordcontroller.text);
                  // var user = Users(id: random.nextInt(99), firstname: firstname, lastname: lastname, username: username, email: email, password: password, confirmationpassword: confirmationpassword)
                  // BlocProvider.of<LoginBloc>(context)
                  //     .add(DoLogin(
                  //         password:
                  //             passwordcontroller.text,
                  //         username:
                  //             usernamecontroller.text));
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
                    "Signin",
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
          ],
        ),
      ),
    ));
  }
}
