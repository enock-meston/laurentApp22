import 'package:Laurent/API_Connection/api_connection.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardController extends GetxController {
  var countIsomo = 0.obs;
  var countQuestionAnswer = 0.obs;
  var countSubscriptions = 0.obs;

  @override
  void onInit() {
    fetchData(); // Call the method when the controller initializes
    super.onInit();
  }

  void fetchData() async {
    try {
      var url = API.dasboard;
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        countIsomo.value = jsonData['CountIsomo'];
        countQuestionAnswer.value = jsonData['CountQuestionAnswer'];
        countSubscriptions.value = jsonData['CountSubscriptions'];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
