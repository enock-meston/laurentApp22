import 'dart:convert';
import 'dart:ui';

import 'package:Laurent/API_Connection/api_connection.dart';
import 'package:Laurent/models/subscription_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SubscriptionController extends GetxController {
  var subscriptionsModel = <SubscriptionModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubscriptions();
  }

  void fetchSubscriptions() async {
    try {
      var url = API.subscriptionView;
      isLoading(true);
      var response = await http.get(Uri.parse(url));
      print('data suscriptions: ${response.body}');
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        Iterable subscriptionsList = jsonResponse['subscription'];
        subscriptionsModel.value = subscriptionsList
            .map((subscription) => SubscriptionModel.fromJson(subscription))
            .toList();
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(
          false); // Ensure isLoading is set to false even in case of error
    }
  }


}
