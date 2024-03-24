import 'package:Laurent/controllers/question_controller.dart';
import 'package:Laurent/models/course_model.dart';
import 'package:Laurent/screens/fragments/exams_fragment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LearnDash2Fragment extends StatefulWidget {
  final CourseModel course;

  const LearnDash2Fragment({Key? key, required this.course}) : super(key: key);

  @override
  _LearnDash2FragmentState createState() => _LearnDash2FragmentState();
}

class _LearnDash2FragmentState extends State<LearnDash2Fragment> {
  late YoutubePlayerController _controller;
  QuestionController questionController = Get.put(QuestionController());

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.course.youtubeUrlLink ?? "",
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    )..addListener(listener);
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
        title: Text(widget.course.title ?? ""),
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 8.0,
                ),
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
                SizedBox(
                  height: 8.0,
                ),
                Text(widget.course.description ?? ""),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                Get.to(()=>ExamsFragment());
              },
              child: Text('Komeza Gukora Ikizamini'),
            ),
          )
        ],
      ),
    );
  }
}
