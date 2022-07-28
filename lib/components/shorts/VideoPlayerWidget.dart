import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoPlayerWidget extends StatelessWidget {
   VideoPlayerWidget(VideoPlayerController? controller, {Key? key}) : super(key: key);
   VideoPlayerController? controller;
  @override
  Widget build(BuildContext context) => 
  controller !=null && controller!.value.isInitialized?
  Container(alignment: Alignment.topCenter,
  child: buildVideo(),
  )
  
  :const SizedBox(
    height: 200,
    child: Center(child: CircularProgressIndicator())
    ,);

    Widget buildVideo()=> buildVideoPlayer();

    Widget buildVideoPlayer()=> VideoPlayer(controller!);
}