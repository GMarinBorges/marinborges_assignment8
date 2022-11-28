// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'api.dart';

import 'editStudentFirstName.dart';
import 'listOfStudents.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final EducationAPI api = EducationAPI();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List programs = [];

  bool _dbLoaded = false;

  void initState() {
    super.initState();

    widget.api.getAllCourses().then((data) {
      setState(() {
        programs = data;
        programs.sort((a, b) {
          return a['courseName']
              .toLowerCase()
              .compareTo(b['courseName'].toLowerCase());
        });
        _dbLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LIST OF COURSES\n" + "Course Name | Instructor | Credits",
            style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
      ),
      body: Center(
          child: _dbLoaded
              ? Column(
                  children: [
                    Expanded(
                      child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(15.0),
                          children: [
                            ...programs
                                .map<Widget>(
                                  (program) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30),
                                    child: TextButton(
                                      onPressed: () => {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  ListOfStudents(
                                                      id: program['courseID'],
                                                      courseName: program[
                                                          'courseName']))),
                                        )
                                      },
                                      child: ListTile(
                                        leading: Text(
                                          program['courseName'.toString()],
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.blue,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        title: Text(
                                            (program[
                                                'courseInstructor'.toString()]),
                                            style: TextStyle(fontSize: 20),
                                            textAlign: TextAlign.center),
                                        trailing: Text(
                                            ("CH: " +
                                                program['courseCredits'
                                                        .toString()]
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
    );
  }
}
