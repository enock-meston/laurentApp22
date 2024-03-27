
import 'package:Laurent/controllers/client_profile_controller.dart';
import 'package:Laurent/service/connectivity_service.dart';
import 'package:Laurent/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ClientProfileController clientProfileController = Get.put(ClientProfileController());

    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splash(),initialBinding: BindingsBuilder((){
      Get.lazyPut<ConnectivityService>(() => ConnectivityService());
    }),
    );
  }
}
