import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/dropdown.dart';
import 'package:form_field_validator/form_field_validator.dart';

class NoteForm extends StatefulWidget {
  NoteForm({Key? key}) : super(key: key);

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  _NoteFormState(){_selectedVal = _menuList[0];}
  String? _selectedVal = null;
  final _dropdownFormKey = GlobalKey<FormState>();
  final _menuList = ["Note","Personal","Work","Travel","Financial",
                     "Gaming","Life","Love","Music","Problems",
                     "Saving","Documents","Education","Secret",];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note"), 
        toolbarHeight: 50,
        backgroundColor: const Color.fromARGB(255, 60, 145, 255),
        titleTextStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(30,50,30,0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration( labelText: "Title",),
              validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Please enter your password"),
                          ]),
            ),

            const SizedBox(height: 15),
            
            // TODO DropdownButton *
            DropdownButtonFormField(
              isExpanded: true,
              style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
              value: _selectedVal,
              items: _menuList.map((e) => DropdownMenuItem(child: Text(e),value: e,)).toList(),   
              onChanged: (val) {
                setState(() {
                  _selectedVal = val as String;
                });
              },
              icon: const Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.white,
              ),
              menuMaxHeight: 200,
              dropdownColor: Colors.lightBlue, 
              decoration:  InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              filled: true,
              fillColor: Colors.blueAccent,
              ),
              // validator: (value) => value == null ? "Select a Type" : null,
            ),

            const SizedBox(height: 15),

            TextFormField(
              style: const TextStyle(height: 1.5),
              decoration:  const InputDecoration(
                labelText: "Content",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 40,horizontal: 15),
               ),
               maxLines: 7,
               minLines: 2,
            ),

            const SizedBox(height: 15),

            TextFormField(
              style: const TextStyle(height: 1.5),
              decoration:  const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(vertical: 30,horizontal: 15),
               ),
               maxLines: 3,
               minLines: 1,
            ),


            const SizedBox(height: 15),

            InkWell(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                width: 150,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape:  RoundedRectangleBorder(
                      borderRadius:  BorderRadius.circular(10)
                    )
                  ),
                child: const Text('Submit',style: TextStyle(fontSize: 18 ),),
                onPressed: () async {
                  
                },
                ),
              ),
            )
          ],
        )),
    );
  }
}