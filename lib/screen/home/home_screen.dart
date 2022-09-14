// ignore_for_file: null_check_always_fails

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/snackbar.dart';
import 'package:flutter_application_1/models/task.dart';
import 'package:flutter_application_1/screen/component/task_card.dart';
import 'package:flutter_application_1/screen/home/detail_screen.dart';
import 'package:flutter_application_1/screen/auth/login.dart';
import 'package:flutter_application_1/screen/navigator/nav_page.dart';
import 'package:flutter_application_1/services/firebase_services.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controller/checktask_controller.dart';
import 'package:flutter_application_1/models/proflie.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageScroll = PageController(viewportFraction: 0.85, keepPage: true);
  List<Color> currentColor = backColor[0];
  final checkTaskController = Get.put(CheckTaskController());
  
  String greeting(){
    var hour  = DateTime.now().hour;
    print(hour);
    if (hour < 12) {return "Morning";
    } else if(hour < 15) {return "Afternoon";
    } else if(hour < 18){return "Evening";
    } else { return "Night";} 
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedContainer(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: currentColor
        ),
      ),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
      child: Scaffold(
        drawer: NavPage(),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          // Todo | Menu bar
          title: const Text("Do app"),
          // Todo | Logout 
          actions: <Widget> [
            Padding(padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () async {
                await FirebaseServices().googleSignOut();
                Get.back();
                LogoutSuccessSnackBar(context);
              },
              child: const Icon(Icons.logout),
            ),)
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          // title: Text("FLUTTER_APPLICATION_1"),
        ),
        floatingActionButton: FabCircularMenu(
          fabOpenIcon: const Icon(Icons.add_rounded, size: 30.0, color: Colors.white,),
          fabCloseColor: Colors.grey[800],
          fabCloseIcon: const Icon(Icons.clear_rounded, size: 30.0, color: Colors.white,),
          // fabOpenColor: Colors.deepOrange[400],
          alignment: Alignment.bottomRight,
          ringColor: Colors.blueAccent.withAlpha(120),
          ringDiameter: 380.0,
          ringWidth: 120.0,
          fabSize: 65.0,
          fabElevation: 5.0,
          fabIconBorder: const CircleBorder(),

          // TODO : Button inside FabCircularMenu
          children: <Widget>[
            RawMaterialButton(
              onPressed: () {},
              elevation: 10.0,
              padding: const EdgeInsets.all(15.0),
              shape: const CircleBorder(),
              child: const Icon(
                Icons.home,
                size: 35.0,
                color: Colors.white,
                ),
            ),
            RawMaterialButton(
              onPressed: () {},
              elevation: 10.0,
              padding: const EdgeInsets.all(15.0),
              shape: const CircleBorder(),
              child: const Icon(
                Icons.my_library_books_rounded,
                size: 30.0,
                color: Colors.white,
                ),
            ),
            RawMaterialButton(
              onPressed: () {},
              elevation: 10.0,
              padding: const EdgeInsets.all(15.0),
              shape: const CircleBorder(),
              child: const Icon(
                Icons.done_all_rounded,
                size: 35.0,
                color: Colors.white,
                ),
            ),
            RawMaterialButton(
              onPressed: () {},
              elevation: 10.0,
              padding: const EdgeInsets.all(15.0),
              shape: const CircleBorder(),
              child: const Icon(
                Icons.settings,
                size: 35.0,
                color: Colors.white,
                ),
            ),
          ],),
        body: SingleChildScrollView( 
          child : Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPaddin * 2,
                  vertical: kDefaultPaddin,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: kDefaultPaddin),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.35),
                                offset: const Offset(0, 5),
                                blurRadius: 15.0,
                                spreadRadius: 0.0,
                              ),
                            ],
                          ),
                          // ignore: prefer_const_constructors
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                const AssetImage("assets/img/avatar/hi.jpg"),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Good ${greeting()},\nน้องปังปอนด์",
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: Colors.white,fontWeight: FontWeight.w600),),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: kDefaultPaddin),
                      child: Text(
                        "You like feel good\nYou have ${checkTaskController.countTodoToday} tasks to do today",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: kDefaultPaddin),
                      child: Obx(() => Text(
                          "Today, ${checkTaskController.dateNow}",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ))
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 400,
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: Obx((){
                      return PageView.builder(
                        allowImplicitScrolling: true,
                        controller: _pageScroll,
                        itemCount: checkTaskController.taskModelList.length,
                        onPageChanged: (index){
                          setState(() {
                            currentColor = backColor[index];
                          });
                        },
                        itemBuilder: (context, index) {
                          return TaskCard(
                            size: size,
                            task: checkTaskController.taskModelList[index],
                            press: () {
                              checkTaskController.getCheckTask(checkTaskController.taskModelList[index].id);
                              checkTaskController.getTaskById(checkTaskController.taskModelList[index].id);
                              Get.toNamed("/detailScreen", arguments: checkTaskController.taskModelList[index]);
                            }, swipe: (DragUpdateDetails ) {  }, 
                          );
                        },
                      );
                  })
                ),
              )
            ],
          ),
          ),
        ),
      ),
    );
  }
}
