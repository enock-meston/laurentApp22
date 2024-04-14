import 'dart:async';

import 'package:Laurent/controllers/question_controller.dart';
import 'package:Laurent/models/question_data.dart';
import 'package:Laurent/screens/fragments/learn_dash_fragment.dart';
import 'package:Laurent/screens/fragments/main_fragment.dart';
import 'package:Laurent/screens/fragments/result_fragment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

  class ExamsFragment extends StatefulWidget {
  String questionEnd;

  ExamsFragment({super.key, required this.questionEnd});

  @override
  State<ExamsFragment> createState() => _ExamsFragmentState();
}

class _ExamsFragmentState extends State<ExamsFragment> {
  int _currentIndex = 0;
  List<Question> questions = [];

  late QuestionController controller;
  //QuestionController controller = Get.put(QuestionController(questionEnd: ExamsFragment.getQuestionEnd.toString()));

  Map<int, dynamic> userAnswers = {}; // Store user's selected answers
  int? currentIndex;
  int _score = 0;
  late Timer _timer;
  int _duration = 1200; // Duration in minutes

  @override
  void initState() {
    super.initState();
    _startTimer();
    print("test: ${widget.questionEnd.toString()}");
    var currentId = widget.questionEnd;
    Future.delayed(Duration(milliseconds: 100), () {
      controller =
          Get.put(QuestionController(questionEnd: currentId.toString()));
      questions = controller.questionDataList!.value;
      print("Question : $questions");
      print("widget.questionEnd :${widget.questionEnd}");
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_duration > 0) {
          _duration--;
        } else {
          // Timer expired for the current question
          _timer.cancel();
          // Handle expiration (e.g., move to the next question)
          if (_currentIndex == questions.length) {
            print("---111");
            // Display result dialog if it's the last question
            _timer.cancel(); // Stop the timer
            _showResultDialog();
          } else {
            print("---222");
            _goToNextQuestion();
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> options = questions[_currentIndex]
        .options!
        .substring(
            1,
            questions[_currentIndex].options!.length -
                1) // Remove square brackets
        .split('","') // Split by ","
        .map(
            (option) => option.replaceAll('"', '')) // Remove surrounding quotes
        .toList();
    var idd1 = widget.questionEnd;
    print("id2: $idd1");

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Exam/Ikizamini",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 253, 112, 11),
      ),
      body: questions.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${questions[_currentIndex].question ?? ''} /amanota ${questions[_currentIndex].marks ?? ''}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          if (questions[_currentIndex].fileUpload != null &&
                              questions[_currentIndex].fileUpload!.isNotEmpty)
                            Image.network(
                              questions[_currentIndex].fileUpload ?? '',
                              width: 200,
                              height: 200,
                            ),
                          SizedBox(height: 20),
                          ...List.generate(options.length, (index) {
                            return RadioListTile(
                              title: Text(options[index]),
                              selected: index == currentIndex,
                              value: index,
                              groupValue: currentIndex,
                              onChanged: (value) {
                                setState(() {
                                  currentIndex = value!;
                                  print("V : $value");
                                  print("CC : $currentIndex");
                                  userAnswers[_currentIndex] = options[value];
                                });
                              },
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed:
                            _currentIndex > 0 ? _goToPreviousQuestion : null,
                        child: const Text('Previous'),
                      ),
                      ElevatedButton(
                        onPressed: _currentIndex < questions.length - 1
                            ? _goToNextQuestion
                            : _showResultDialog,
                        child: _currentIndex < questions.length - 1
                            ? const Text('Next')
                            : const Text('Soza Ikizami'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Igihe Gisigaye: ${_duration ~/ 60}:${(_duration % 60).toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
          : const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.list_bullet),
                SizedBox(
                  height: 10,
                ),
                Text("No Questions"),
              ],
            ),
    );
  }

  void _goToPreviousQuestion() {
    setState(() {
      print("_C : $_currentIndex");
      print("User : $userAnswers");

      // _timer.cancel();
      // _duration = 60;
      // _startTimer();

      // currentIndex = userAnswers.containsKey(_currentIndex)
      //     ? userAnswers.keys.first
      //     : null;
      _currentIndex--;
      for (var entry in userAnswers.entries) {
        var key = entry.key;

        if (key == _currentIndex) {
          print("K : $key");
          currentIndex = key + 1;
          print("K CurrentIndex : $currentIndex");
          break;
        } else {
          print("Null");
          currentIndex = null;
        }
      }
      print("C : $currentIndex");

      // currentIndex = null;
    });
  }

  void _goToNextQuestion() {
    setState(() {
      // _timer.cancel();
      // _duration = 60;

      if (_currentIndex < questions.length - 1) {
        print("current index : ${_currentIndex}");
        print("length  : ${questions.length}");

        // _startTimer();
      } else {
        _timer.cancel(); // Stop the timer
        _showResultDialog();
        return;
      }
      print("User : ${userAnswers}");

      userAnswers.forEach((key, value) {
        if (key == _currentIndex) {
          currentIndex = key;
        } else {
          currentIndex = null;
        }
      });

      _currentIndex++;
      currentIndex = null;

      print("_C : $_currentIndex");
      print("C : $currentIndex");
    });
  }

  void _showResultDialog() {
    int totalQuestions = questions.length;
    int correctAnswers = 0;
    List<Map<String, dynamic>> resultDetails = [];

    for (int i = 0; i < totalQuestions; i++) {
      String? userAnswer = userAnswers[i];
      String correctAnswer =
      questions[i].answer!.substring(2, questions[i].answer!.length - 2);
      if (userAnswer != null) {
        if (correctAnswer.contains(userAnswer)) {
          correctAnswers++;
        } else {
          resultDetails.add({
            'question': questions[i].question,
            'correctAnswer': questions[i].answer,
            'fileUpload': questions[i].fileUpload,
            'userAnswer': userAnswer,
          });
        }
      }
    }

    Get.offAll(() => ResultFragment(
      totalQuestions: totalQuestions,
      correctAnswers: correctAnswers,
      resultDetails: resultDetails,
      onClose: () {
        Get.offAll(() => MainFragment());
      },
    ));
  // void _showResultDialog() {
  //   int totalQuestions = questions.length;
  //   int correctAnswers = 0;
  //   List<Map<String, dynamic>> resultDetails = [];
  //
  //   for (int i = 0; i < totalQuestions; i++) {
  //     String? userAnswer = userAnswers[i];
  //     String correctAnswer =
  //         questions[i].answer!.substring(2, questions[i].answer!.length - 2);
  //     print("My : $userAnswer");
  //     print("Correct : $correctAnswer");
  //     // int correctIndex = questions![i]['correctIndex'];
  //     if (userAnswer != null) {
  //       if (correctAnswer.contains(userAnswer)) {
  //         correctAnswers++;
  //       } else {
  //         resultDetails.add({
  //           'question': questions[i].question,
  //           'correctAnswer': questions[i].answer,
  //           'fileUpload': questions[i].fileUpload,
  //           'userAnswer': userAnswer,
  //         });
  //       }
  //     }
  //   }
  //
  //   _score = correctAnswers;
  //
  //
  //
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         scrollable: true,
  //         title: const Text('Ibisubizo by\'ikizamini'),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisSize: MainAxisSize.max,
  //             children: [
  //               Row(
  //                 children: [
  //                   const Text(
  //                     'Ibibazo Byose: ',
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.w800,
  //                     ),
  //                   ),
  //                   Text('$totalQuestions'),
  //                 ],
  //               ),
  //               Text('Ibisubizo Byukuri: $correctAnswers'),
  //               Text('Amanota yawe: $_score / $totalQuestions',
  //               style: TextStyle(
  //                             color: Colors.green,
  //                           )),
  //               SizedBox(height: 20),
  //               Visibility(
  //                 visible: resultDetails.isNotEmpty,
  //                 child: const Text(
  //                   'Ibisubizo Bitari byo:',
  //                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
  //                 ),
  //               ),
  //               ...resultDetails.map((result) => Column(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     mainAxisSize: MainAxisSize.max,
  //                     children: [
  //                       Column(
  //                         children: [
  //                           const Text(
  //                             'Ikibazo:',
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.w800,
  //                             ),
  //                           ),
  //                           Text('${result['question']}'),
  //                         ],
  //                       ),
  //                       Column(
  //                         children: [
  //                           const Text(
  //                             'Ifoto:',
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.w800,
  //                             ),
  //                           ),
  //                           if (result['fileUpload'] != null)
  //                             Image.network(
  //                               result['fileUpload'],
  //                               width: 200,
  //                               height: 200,
  //                             ),
  //                         ],
  //                       ),
  //                       Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisSize: MainAxisSize.max,
  //                         children: [
  //                         const Text(
  //                           'Igisubizo Cy\'ukuri:',
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.w800,
  //                           ),
  //                         ),
  //                         Text(
  //                           '${result['correctAnswer'].replaceAll('[', '').replaceAll(']', '').replaceAll('"', '')}',
  //                           style: TextStyle(
  //                             color: Colors.green,
  //                           ),
  //                         ),
  //                       ]),
  //                       Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisSize: MainAxisSize.max,
  //                         children: [
  //                         const Text(
  //                           'Igisubizo cyawe:',
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.w800,
  //                           ),
  //                         ),
  //                         Text(' ${result['userAnswer']}',
  //                         style: TextStyle(
  //                             color: Colors.red,
  //                           ),),
  //                       ]),
  //                       const Divider(
  //                         height: 20,
  //                         color: Colors.black,
  //                         thickness: 0.5,
  //                       )
  //                     ],
  //                   )),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('Funga'),
  //             onPressed: () {
  //               // Navigator.of(context).pop();
  //               Get.offAll(() => MainFragment());
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );

  }
}
