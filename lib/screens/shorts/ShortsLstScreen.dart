import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/models/User.dart';
import 'package:socialmedia/repository/ShortsRepository.dart';
import 'package:socialmedia/response/shortsResponse/ShortsResponse.dart';
import 'package:socialmedia/components/shorts/VideoPlayerWidg.dart';
import 'package:video_player/video_player.dart';

import 'package:socialmedia/models/ShortsModel.dart';
import 'package:get/get.dart';

class ShortsLstScreen extends StatefulWidget {
  static const String id = "shorts_ls";
  const ShortsLstScreen({Key? key}) : super(key: key);

  @override
  State<ShortsLstScreen> createState() => _ShortsLstScreenState();
}

class _ShortsLstScreenState extends State<ShortsLstScreen> {
  RxString userid = ''.obs;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      var data = (prefs.getString('userdata') ?? '');
      var userdatas = User.fromJson(jsonDecode(data.toString()));
      userid.value = userdatas.id.toString();

      // if(likeslist!.contains(userid)){
      //   liked.value = true;

      // }

      // if(saveList!.contains(userid)){
      //   userSaved.value = true;

      // }
    });
  }

  // VideoPlayerController? _controller;
  // Future<void>? _initializeVideoPlayerFuture;
  // @override
  // void initState() {
  //   _controller = VideoPlayerController.network(
  //       "https://flutter.github.io/assets-for-api-docs/assets/videos/but");
  //   _initializeVideoPlayerFuture = _controller?.initialize();
  //   _controller?.setLooping(true);
  //   _controller?.setVolume(1.0);
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _controller!.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ShortsResponse?>(
        future: ShortsRepository().getShorts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              List<ShortsModel?> shortlst = snapshot.data!.shorts;

              return PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: shortlst.length,
                  itemBuilder: (context, index) {
                    return VideoPlayerWidg(
                        url: shortlst[index]!.video,
                        profilePicture:
                            shortlst[index]!.userid!.profilePicture!,
                        username: shortlst[index]!.userid!.username!,
                        location: shortlst[index]?.userid?.location,
                        description: shortlst[index]!.description!,
                        createdAt: shortlst[index]!.createdAt!,
                        createdBy: shortlst[index]!.userid!.id!,
                        loginuserid:userid.value,
                        );
                  });
            } else {
              return const Center(
                child: Text("No data"),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:socialmedia/components/shorts/VideoPlayerWidget.dart';
// class ShortsLstScreen extends StatefulWidget {
//   static const String id = "shorts_lst";
//    ShortsLstScreen({Key? key}) : super(key: key);

//   @override
//   State<ShortsLstScreen> createState() => _ShortsLstScreenState();
// }

// class _ShortsLstScreenState extends State<ShortsLstScreen> {
//    VideoPlayerController? controller;
//    final asset = 'https://pixabay.com/videos/id-66810/';
//    @override
//    void initState(){
//     super.initState();
//     controller = VideoPlayerController.network(asset)
//     ..addListener(()=> setState((){}))..setLooping(true)..initialize().then((_) => controller!.play());
//    }

//    @override
//    void disponse(){
//     controller!.dispose();
//     super.dispose();
//    }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:Container(child:
//       VideoPlayerWidget(controller)
//        ,)
//     );
    
//   }
// }