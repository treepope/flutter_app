import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/screen/auth/joinRegister.dart';
import 'package:flutter_application_1/screen/auth/register.dart';
import 'package:flutter_application_1/screen/home/home_screen.dart';
import 'package:flutter_application_1/screen/auth/login.dart';
import 'package:get/get.dart';

class ConfigRouter {
//! old : RouterConfig
	static final route = [
    GetPage(name: '/loginScreen', page: () => LoginScreen(User), transition: Transition.fade),
    GetPage(name: '/homeScreen', page: () => const HomeScreen(), transition: Transition.rightToLeft),
    GetPage(name: '/joinScreen', page: () => JoinScreen(), transition: Transition.rightToLeft),
    GetPage(name: '/registerScreen', page: () => RegisterScreen(), transition: Transition.rightToLeft),
	];
	
}
	