import 'package:Laurent/controllers/client_profile_controller.dart';
import 'package:Laurent/screens/fragments/home_fragment.dart';
import 'package:Laurent/screens/fragments/learn_dash_fragment.dart';
import 'package:Laurent/screens/fragments/profile_fragment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainFragment extends StatefulWidget {
  @override
  State<MainFragment> createState() => _MainFragmentState();
}

class _MainFragmentState extends State<MainFragment> {
  ClientProfileController clientProfileController = Get.put(ClientProfileController());
  int currentIndex = 0;

  final screens = [
    //screens
    const HomeFragment(),
    LearnDashFragment(),
    ProfileFragment(),
    
  ];

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: screens,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 253, 112, 11),
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: const Color.fromARGB(255, 13, 13, 13),
        iconSize: 30,
        onTap: (index) {
          // Set the selected index and animate to the corresponding page
          setState(() {
            currentIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: [
         const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Learn",
          ),
         const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
