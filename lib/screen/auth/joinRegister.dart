import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/auth/register.dart';
import 'package:get/get.dart';

class JoinScreen extends StatefulWidget {

  @override
  _JoinScreenState createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create account"),
      toolbarHeight: 50,
      // centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 60, 145, 255),
      titleTextStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
      ),
      body: Padding(padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
        child: Container(decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/img/join-ppl.png'),
                  alignment: Alignment.topCenter)),
          child: Padding( padding: const EdgeInsets.fromLTRB(30, 220, 30, 0),
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  const SizedBox(height: 40),
                  
                  const Text(
                    'Join Do',style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),),
                  
                  const SizedBox(height: 5,),
                  
                  const Text(
                    "creating an account here is very easy.",style: TextStyle(
                      fontSize: 13,
                    ),),
                  
                  const SizedBox(height: 60),
                  
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10)
                        )
                      ),
                    child: Text('Next',style: TextStyle(fontSize: 16),),
                      onPressed: () {
                        Get.to(RegisterScreen());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
