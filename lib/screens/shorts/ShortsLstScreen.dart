import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:socialmedia/components/shorts/VideoPlayerWidget.dart';
class ShortsLstScreen extends StatefulWidget {
  static const String id = "shorts_lst";
   ShortsLstScreen({Key? key}) : super(key: key);

  @override
  State<ShortsLstScreen> createState() => _ShortsLstScreenState();
}

class _ShortsLstScreenState extends State<ShortsLstScreen> {
   VideoPlayerController? controller;
   final asset = 'https://pixabay.com/videos/id-66810/';
   @override
   void initState(){
    super.initState();
    controller = VideoPlayerController.network(asset)
    ..addListener(()=> setState((){}))..setLooping(true)..initialize().then((_) => controller!.play());
   }

   @override
   void disponse(){
    controller!.dispose();
    super.dispose();
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(child:
      VideoPlayerWidget(controller)
       ,)
    );
    
  }
}