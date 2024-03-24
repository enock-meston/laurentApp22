import 'dart:convert';

import 'package:Laurent/API_Connection/api_connection.dart';
import 'package:Laurent/models/question_data.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class QuestionController extends GetxController {
  RxList<Question>? questionDataList = RxList();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    questionDataList?.value = (await fetchQuestionsList())!;
    print("Qus : $questionDataList");
  }

  static Future<List<Question>?> fetchQuestionsList() async {
    final url = Uri.parse(API.question);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print("Response Body : ${response.body }");
        final jsonData = jsonDecode(response.body);
        final questionData = QuestionData.fromJson(jsonData);
        return questionData.question;
      } else {
        throw Exception('Failed to load questions');
      }
    } catch (e) {
      print('Error fetching questions: $e');
      return null;
    }
  }
}
