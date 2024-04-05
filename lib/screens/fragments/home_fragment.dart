import 'package:Laurent/controllers/dashboard_controller.dart';
import 'package:Laurent/controllers/recent_course_controller.dart';
import 'package:Laurent/service/connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);
  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  String _username = '';
  final DashboardController dashboardController =
      Get.put(DashboardController());
  final RecentCourseController recentCourseController =
      Get.put(RecentCourseController());
  final ConnectivityService connectivityService =
      Get.put(ConnectivityService());

  @override
  void initState() {
    super.initState();
    _retrieveUsername();
  }

  Future<void> _retrieveUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('names') ?? '';
    setState(() {
      _username = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home/Ahabanza',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 253, 112, 11),
      ),
      body: Obx(() {
        if (!connectivityService.isConnected.value) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            Get.snackbar(
              'No Internet Connection',
              'Please check your internet connection.',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          });
        }
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Murakaza Neza, $_username!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ibikorwa By\'Umunsi',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildStatCard('Amasomo',
                                    dashboardController.countIsomo.string),
                                _buildStatCard(
                                    'Ibibazo',
                                    dashboardController
                                        .countQuestionAnswer.string),
                                _buildStatCard(
                                    'Ifatabuguzi',
                                    dashboardController
                                        .countSubscriptions.string),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Amasomo ya Mashyashya',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GetX<RecentCourseController>(
                  builder: (controller) {
                    if (controller.recentCourses.isEmpty) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: controller.recentCourses.length,
                        itemBuilder: (context, index) {
                          var course = controller.recentCourses[index];
                          return ListTile(
                            title: Text(course.title),
                            subtitle: Text(course.description),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 253, 112, 11),
                              child: Icon(Icons.recent_actors),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              // FloatingActionButton(
              //   onPressed: () => {
              //     recentCourseController.fetchRecentCourses(),
              //   },
              //   child: Icon(Icons.refresh),
              // ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
