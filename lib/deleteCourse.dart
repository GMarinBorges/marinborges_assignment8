// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'api.dart';
import 'main.dart';

class deleteCourseClass extends StatefulWidget {
  final String id, courseName;

  final EducationAPI api = EducationAPI();

  deleteCourseClass(this.id, this.courseName);

  @override
  _EditCourseState createState() => _EditCourseState(id, courseName);
}

class _EditCourseState extends State<deleteCourseClass> {
  final String id, courseName;

  _EditCourseState(this.id, this.courseName);

  void _changeDeleteCourse(id, courseName) {
    setState(() {
      widget.api.editStudentFirstName(id, courseName);
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
          widget.courseName,
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
                    'Enter a new "COURSE ID" for ${widget.courseName}',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: textController,
                  ),
                  ElevatedButton(
                      onPressed: () => {
                            _changeDeleteCourse(widget.id, textController.text),
                          },
                      child: Text("Delete Course")),
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
