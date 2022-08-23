import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/register.dart';

class JoinScreen extends StatefulWidget {

  @override
  _JoinScreentState createState() => _JoinScreentState();
}

class _JoinScreentState extends State<JoinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text('Create account'),
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

                  const SizedBox(
                    height: 40,
                  ),
                  
                  const Text(
                    'Join Do',style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(
                    height: 5,
                  ),
                  
                  const Text(
                    "We'll help you to create a new accountin a few easy steps",style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  
                  const SizedBox(
                    height: 60,
                  ),
                  
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      child: Text('Next', style: TextStyle(fontSize: 16)),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return RegisterScreen();
                        }));
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
