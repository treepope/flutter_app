// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/auth/login.dart';
import 'package:flutter_application_1/screen/navigator/account/account_home.dart';
import 'package:flutter_application_1/screen/navigator/notes/note_fetchData.dart';
import 'package:flutter_application_1/screen/navigator/settings/settings_home.dart';
import 'package:flutter_application_1/screen/navigator/tasks/tasks_home.dart';
import 'package:flutter_application_1/services/firebase_services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/models/snackbar.dart';

import '../../main.dart';

class NavPage extends StatelessWidget {
// * Facebook auth var
Map? _userData;

// notification logout
Future<void> _showNotification_Logout() async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'Do_noti_001' , 'General Notifications', 'noti',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'tricker'
    );

    const NotificationDetails platfromChannelDetails = 
    NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0, 'Log out', '', platfromChannelDetails);
  }


  @override
  Widget build(BuildContext context) => Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget> [
          buildHeader(context),
          buildMenuItems(context),
        ],
      )
    ),
  );

  Widget buildHeader(BuildContext context) => Container(
    // padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: const Image(
      image: AssetImage('assets/img/login-cover.png'),
      fit: BoxFit.cover),
  );
  Widget buildMenuItems(BuildContext context) => Column(
    children: [
      const Padding(padding: EdgeInsets.only(top: 10)),
      ListTile(
        leading: const Icon(Icons.account_circle_rounded),
        title: const Text('My Account'),
        onTap: () {
          Get.to(const AccountPage());
        } ),
      ListTile(
        leading: const Icon(Icons.my_library_books_rounded),
        title: const Text('Note'),
        onTap: () {
           Get.to(const FetchData());
        },
      ),
      ListTile(
        leading: const Icon(Icons.done_all_rounded),
        title: const Text('Done list'),
        onTap: () {
           Get.to(const TasksPage());
        },
      ),

      // TODO: Logout
      ListTile(
        leading: const Icon(Icons.logout_rounded),
        title: const Text('Log out'),
        onTap: () async {
          await FirebaseServices().googleSignOut();
          await FacebookAuth.i.logOut();
          _userData = null;

          Get.to(() => LoginScreen(User));
          _showNotification_Logout();
          LogoutSuccessSnackBar(context);

        },
      ),
    ],
  );
}