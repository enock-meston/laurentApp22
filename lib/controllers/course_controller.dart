import 'package:Laurent/API_Connection/api_connection.dart';
import 'package:Laurent/models/course_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class CourseController extends GetxController {
  var courses = <CourseModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCourseData();
  }

  Future<void> fetchCourseData() async {
    try {
      // Replace this URL with your actual API endpoint
      var url = API.courses;
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<CourseModel> loadedCourses = [];
        for (var course in jsonData['courses']) {
          loadedCourses.add(CourseModel.fromJson(course));
        }
        courses.value = loadedCourses;
      } else {
        throw Exception('Failed to load course data');
      }
    } catch (error) {
      print('Error fetching course data: $error');
    }
  }



}
