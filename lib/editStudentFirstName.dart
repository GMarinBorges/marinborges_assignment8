// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'api.dart';
import 'main.dart';

class EditStudentClass extends StatefulWidget {
  final String id, fname;

  final EducationAPI api = EducationAPI();

  EditStudentClass(this.id, this.fname);

  @override
  _EditStudentState createState() => _EditStudentState(id, fname);
}

class _EditStudentState extends State<EditStudentClass> {
  final String id, fname;

  _EditStudentState(this.id, this.fname);

  void _changeStudentFirstName(id, fname) {
    setState(() {
      widget.api.editStudentFirstName(id, fname);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.fname,
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Text(
                    'Enter a new "FIRST NAME" for ${widget.fname}',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: textController,
                  ),
                  ElevatedButton(
                      onPressed: () => {
                            _changeStudentFirstName(
                                widget.id, textController.text),
                          },
                      child: Text("Change Name")),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: () => {
                Navigator.pop(context),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage())),
              }),
    );
  }
}
