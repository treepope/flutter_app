// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/screen/home/home_screen.dart';
import 'package:flutter_application_1/screen/auth/login.dart';
import 'package:flutter_application_1/screen/navigator/account/account_home.dart';
import 'package:flutter_application_1/screen/navigator/notes/note_home.dart';
import 'package:flutter_application_1/screen/navigator/settings/settings_home.dart';
import 'package:flutter_application_1/screen/navigator/tasks/tasks_home.dart';
import 'package:flutter_application_1/services/firebase_services.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/models/snackbar.dart';

class NavPage extends StatelessWidget {

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
           Get.to(const NotePage());
        },
      ),
      ListTile(
        leading: const Icon(Icons.done_all_rounded),
        title: const Text('Done list'),
        onTap: () {
           Get.to(const TasksPage());
        },
      ),
      ListTile(
        leading: const Icon(Icons.settings),
        title: const Text('Settings'),
        onTap: () {
           Get.to(const SettingsPage());
        },
      ),

      // TODO: Logout
      ListTile(
        leading: const Icon(Icons.logout_rounded),
        title: const Text('Log out'),
        onTap: () async {
          await FirebaseServices().googleSignOut();
          Get.to(() => LoginScreen(User));
          LogoutSuccessSnackBar(context);
        },
      ),
    ],
  );
}