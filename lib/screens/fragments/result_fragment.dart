import 'package:flutter/material.dart';

class ResultFragment extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;
  final List<Map<String, dynamic>> resultDetails;
  final VoidCallback onClose;

  ResultFragment({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.resultDetails,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ibisubizo by\'ikizamini'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  const Text(
                    'Ibibazo Byose: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text('$totalQuestions'),
                ],
              ),
              Text('Ibisubizo Byukuri: $correctAnswers'),
              Text(
                'Amanota yawe: $correctAnswers / $totalQuestions',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 20),
              Visibility(
                visible: resultDetails.isNotEmpty,
                child: const Text(
                  'Ibisubizo Bitari byo:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              ...resultDetails.map((result) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Ikibazo:',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text('${result['question']}'),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Ifoto:',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      if (result['fileUpload'] != null)
                        Image.network(
                          result['fileUpload'],
                          width: 200,
                          height: 200,
                        ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        'Igisubizo Cy\'ukuri:',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        '${result['correctAnswer'].replaceAll('[', '').replaceAll(']', '').replaceAll('"', '')}',
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        'Igisubizo cyawe:',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        ' ${result['userAnswer']}',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 20,
                    color: Colors.black,
                    thickness: 0.5,
                  )
                ],
              )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onClose,
        child: Icon(Icons.close),
      ),
    );
  }
}
