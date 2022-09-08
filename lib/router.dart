import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/screen/home/detail_screen.dart';
import 'package:flutter_application_1/screen/home/add_screen.dart';
import 'package:flutter_application_1/screen/home/home_screen.dart';
import 'package:flutter_application_1/screen/home/login.dart';
import 'package:get/get.dart';

class ConfigRouter {
//! old : RouterConfig

	static final route = [
		GetPage(name: '/detailScreen', page: () => DetailScreen(), transition: Transition.fade),
		GetPage(name: '/addScreen', page: () => AddScreen(), transition: Transition.rightToLeft),
		GetPage(name: '/homeScreen', page: () => HomeScreen()),
    GetPage(name: '/loginScreen', page: () => LoginScreen(User)),
	];
	
}
	