import 'package:Laurent/API_Connection/api_connection.dart';
import 'package:Laurent/models/client_profile_model.dart';
import 'package:Laurent/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ClientProfileController extends GetxController {
  var clientProfile = ClientProfileModel().obs;

  Future<void> fetchClientData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var myId = await sharedPreferences.getInt('id');
    // print('my id $myId');
    String url = API.profile+"/$myId";
    // print('my url $url');
    final response = await http.get(Uri.parse(url));
    // print('my Data ${response.body}');
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['client']; // yes cool
       print('my Data ${jsonData}');
      clientProfile.value = ClientProfileModel.fromJson(jsonData);
      // print('Client Profile: ${clientProfile.value.email}');
    } else {
      throw Exception('Failed to load client data');
    }
  }

  Future<void> signOutUser() async {
    var resultResponse = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: const Text(
          "Ubumwa",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Nibyo Koko,\nUrashaka Gusohoka Muri porogaramu?",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Hoya",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: "loggedOut");
            },
            child: const Text(
              "Yego",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
    if (resultResponse == "loggedOut") {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      await sharedPreferences.remove("id");
        Get.offAll(LoginScreen());

    }
  }

}
