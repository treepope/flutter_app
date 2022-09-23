import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/auth/login.dart';
import 'package:get/get.dart';
import "package:flutter_application_1/router.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: ConfigRouter.route, //! old : RouterConfig.route
      initialRoute: '/loginScreen',
      defaultTransition: Transition.fade,
      title: 'Demo App',
      theme: ThemeData(
        // textTheme: 
        //   Theme.of(context).textTheme.apply(bodyColor: DefalutColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(User),
    );
  }
}