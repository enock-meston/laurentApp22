import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Laurent/controllers/course_controller.dart';
import 'package:Laurent/models/course_model.dart';

import 'learn_dash2_fragment.dart';

class LearnDashFragment extends StatelessWidget {
  final CourseController courseController = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn/Kwiga',style: TextStyle(
          color: Colors.white,
        )),
        backgroundColor: const Color.fromARGB(255, 253, 112, 11),
      ),
      body: Obx(() {
        if (courseController.courses.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: courseController.courses.length,
            itemBuilder: (BuildContext context, int index) {
              CourseModel course = courseController.courses[index];
              return ListTile(
                leading: Icon(Icons.directions_car),
                title: Text(course.title),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Get.to(LearnDash2Fragment(course: course));
                },
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // clientProfileController.fetchClientData();
          courseController.fetchCourseData();
        },
        backgroundColor: const Color.fromARGB(255, 253, 112, 11),
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }
}
