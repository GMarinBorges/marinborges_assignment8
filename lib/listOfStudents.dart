// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:marinborges_assignment8/Models/courseModel.dart';
import 'api.dart';

import 'editStudentFirstName.dart';
import 'listOfStudents.dart';
import 'main.dart';

/*void main() {
  runApp(const listOfStudents());
}*/

/*class ListOfStudents extends StatelessWidget {
  final String id, courseName;
  ListOfStudents({super.key, required this.id, required this.courseName});*/

//final String courseName;

class ListOfStudents extends StatefulWidget {
  final String id, courseName;
  ListOfStudents({super.key, required this.id, required this.courseName});

  final EducationAPI api = EducationAPI();

  @override
  State<ListOfStudents> createState() => _ListOfStudentsState();
}

class _ListOfStudentsState extends State<ListOfStudents> {
  List learners = [];
  bool _dbLoaded = false;

  void initState() {
    super.initState();

    widget.api.getAllStudents().then((data) {
      setState(() {
        learners = data;
        learners.sort((a, b) {
          return a['fname'].toLowerCase().compareTo(b['fname'].toLowerCase());
        });
        _dbLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.courseName + "\n" + "First Name | Last Name | Student ID",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center),
      ),
      body: Center(
          child: _dbLoaded
              ? Column(
                  children: [
                    ElevatedButton(
                        child: Text("Delete Course",
                            style:
                                TextStyle(fontSize: 21, color: Colors.white)),
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: (() {
                          //Routes you to chevyspage.dart
                          widget.api.deleteCourses(widget.id).then((value) => {
                                Navigator.pop(context),
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()),
                                )
                              });
                        })),
                    Expanded(
                      child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(15.0),
                          children: [
                            ...learners
                                .map<Widget>(
                                  (learner) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30),
                                    child: TextButton(
                                      onPressed: () => {
                                        Navigator.pop(context),
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditStudentClass(
                                                        learner['_id'],
                                                        learner['fname']))),
                                      },
                                      child: ListTile(
                                        leading: Text(
                                          learner['fname'],
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.blue,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        title: Text((learner['lname']),
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.red,
                                            ),
                                            textAlign: TextAlign.center),
                                        trailing: Text(
                                            ("ID: " +
                                                learner['studentID']
                                                    .toString()),
                                            style: TextStyle(fontSize: 20),
                                            textAlign: TextAlign.center),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ]),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Database Loading",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    CircularProgressIndicator()
                  ],
                )),
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
