import "package:dio/dio.dart";

import './Models/courseModel.dart';
import './Models/studentModel.dart';

const String localhost = "http://10.0.2.2:1200/";

class EducationAPI {
  final _dio = Dio(BaseOptions(baseUrl: localhost));

  Future<List> getAllStudents() async {
    final response = await _dio.get('/getAllStudents');

    return response.data['learners'];
  }

  Future<List> getAllCourses() async {
    final response = await _dio.get('/getAllCourses');

    return response.data['programs'];
  }

  Future deleteCourses(String courseID) async {
    await _dio.post('/deleteCourseById', data: {"courseID": courseID});
  }

  Future editStudentFirstName(String id, String fname) async {
    await _dio.post('/editStudentById', data: {'id': id, 'fname': fname});
  }
}
