import 'package:flutter/material.dart';
import 'package:socialmedia/utils/url.dart';
import 'package:video_player/video_player.dart';

class ShortsCard extends StatefulWidget {
  String? url;
  ShortsCard({this.url, Key? key}) : super(key: key);

  @override
  State<ShortsCard> createState() => _ShortsCardState();
}

class _ShortsCardState extends State<ShortsCard> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(baseUr + widget.url!)
      ..setLooping(true)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller!.pause();
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        VideoPlayer(_controller!),
        Positioned(
          top: 10,
          right: 10,
          child: const Icon(
            Icons.play_arrow_sharp,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
