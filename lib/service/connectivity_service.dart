import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      checkConnectivity();
    });
  }

  void checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      isConnected.value = false;
      // Show popup or perform action when there's no internet connection
      Get.snackbar(
        'No Internet Connection',
        'Please check your internet connection.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      isConnected.value = true;
    }
  }
}
