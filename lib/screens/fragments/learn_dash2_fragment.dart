import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Laurent/controllers/question_controller.dart';
import 'package:Laurent/models/course_model.dart';
import 'package:Laurent/screens/fragments/exams_fragment.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LearnDash2Fragment extends StatefulWidget {
  final CourseModel course;

  const LearnDash2Fragment({Key? key, required this.course}) : super(key: key);

  @override
  _LearnDash2FragmentState createState() => _LearnDash2FragmentState();
}

class _LearnDash2FragmentState extends State<LearnDash2Fragment> {
  late YoutubePlayerController _controller;
  late QuestionController questionController;
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    questionController = Get.put(QuestionController(questionEnd: widget.course.id.toString()));

    _controller = YoutubePlayerController(
      initialVideoId: widget.course.youtubeUrlLink ?? "",
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    )..addListener(listener);

    // Set _showButton to true after 10 seconds
    Future.delayed(Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          _showButton = true;
        });
      }
    });
  }

  void listener() {
    if (_controller?.value.errorCode != null) {
      print(_controller?.value.errorCode);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.title ?? "", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 253, 112, 11),
      ),
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(height: 8.0),
                        YoutubePlayerBuilder(
                          player: YoutubePlayer(
                            controller: _controller!,
                          ),
                          builder: (context, player) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    // or adjust according to your video aspect ratio
                                    child: player,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: 8.0),
                        Text(widget.course.description ?? ""),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _showButton
                  ? TextButton(
                      onPressed: () async {
                        var courseID = widget.course.id;
                        // so i need the ID of course example :1
                        print("C ID : $courseID");
                        Get.to(() => ExamsFragment(questionEnd: courseID.toString()));
                      },
                      child: const Text('Kanda Gukora Ikizamini'),
                    )
                  : Container(), // Placeholder widget
            ),
          ),
        ],
      ),
    );
  }
}
