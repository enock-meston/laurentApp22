import 'package:Laurent/API_Connection/api_connection.dart';
import 'package:Laurent/models/recent_courses.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RecentCourseController extends GetxController {
  var recentCourses = List<RecentCourse>.empty().obs;

  @override
  void onInit() {
    fetchRecentCourses();
    super.onInit();
  }

  void fetchRecentCourses() async {
    try {
      var url = API.dasboardRecentCourse;
      var response = await http.get(Uri.parse(url));
      // print('data recent: ${response.body}');
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        List<RecentCourse> courses = [];
        for (var course in jsonResponse) {
          courses.add(RecentCourse.fromJson(course));
        }
        recentCourses.assignAll(courses);
      } else {
        // Handle error
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Exception occurred while fetching data: $e');
    }
  }
}
