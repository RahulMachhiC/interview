import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:interview/bloc/createuser/createuser_bloc.dart';
import 'package:interview/bloc/edituser/edit_user_bloc.dart';
import 'package:interview/screens/dashboardscreen.dart';
import 'package:interview/screens/loginscreen.dart';

import 'package:interview/screens/regsiterscreen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import 'bloc/user/user_bloc.dart';

var storage = GetStorage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetStorage.init();
// Open the database and store the reference.

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => CreateuserBloc(),
        ),
        BlocProvider(
          create: (context) => EditUserBloc(),
        ),
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const DashboardScreen(),
            );
          }),
    );
  }
}
