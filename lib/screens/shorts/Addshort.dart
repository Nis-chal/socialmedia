import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/models/User.dart';

import 'package:socialmedia/utils/url.dart';
import 'package:video_player/video_player.dart';

class AddShortScreen extends StatefulWidget {
  static const String id = 'add_screen_screen';
  Map arguments;

  AddShortScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  State<AddShortScreen> createState() => _AddShortScreenState();
}

class _AddShortScreenState extends State<AddShortScreen> {
  final _location = TextEditingController();
  final _description = TextEditingController();
  RxString userid = "".obs;

  VideoPlayerController? _controller;
  RxBool isPauseAnimation = false.obs;
  RxString profilePicture = ''.obs;

  @override
  void initState() {
    _loaduserdata();
    _controller = VideoPlayerController.file(widget.arguments['file'])
      ..setLooping(true)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          // _controller!.play();
        });
      });
    super.initState();
  }

  _loaduserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = (prefs.getString('userdata') ?? '');
    var userdatas = User.fromJson(jsonDecode(data.toString()));
    userid.value = userdatas.id.toString();
    profilePicture.value = userdatas.profilePicture!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(

      //   title: Text('Edit Info'),
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      //   shadowColor: Colors.transparent,
      //   leading: ElevatedButton(child: Text('cancel'), onPressed: (){},
      //   style: ElevatedButton.styleFrom(

      //     minimumSize: Size(30, 10)
      //   ),)

      //   ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('cancel'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    onPrimary: Colors.black,
                    shadowColor: Colors.transparent,
                  ),
                ),
                Text(
                  "Edit Info",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // bool post = await PostRepository().updatePost(
                    //     _location.text,
                    //     _description.text,
                    //     args['postid'],
                    //     args['postimage']);

                    // if (post) {
                    //   Navigator.pushNamed(context, PostDetailScreen.id,
                    //       arguments: args['postid']!);
                    // }
                  },
                  child: Text('Done'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    onPrimary: Colors.blue[600],
                    shadowColor: Colors.transparent,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Obx(
                    () => CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          NetworkImage('$baseUr${profilePicture.value}'),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _description..text = 'he',
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: 'Add description',
                          labelText: 'Description',
                          labelStyle: TextStyle(color: Colors.black45),
                          hintStyle: TextStyle(color: Colors.black45),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent))),
                      autofocus: true,
                    ),
                  ),
                  Stack(children: [
                    Container(
                      height: 70,
                      width: 79,
                      child: VideoPlayer(_controller!),
                    ),
                    Positioned(
                        top: -9,
                        right: -10,
                        child: IconButton(
                          icon: const Icon(
                            Icons.play_arrow_sharp,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                contentPadding: EdgeInsets.all(10),
                                content: Container(
                                  width: 900,
                                  height: 490,
                                  child: GestureDetector(
                                    onTap: () {
                                      isPauseAnimation.value =
                                          !isPauseAnimation.value;
                                      if (isPauseAnimation.value) {
                                        _controller!.pause();
                                      } else {
                                        _controller!.play();
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        VideoPlayer(_controller!),
                                        Positioned(
                                          top: 250,
                                          left: 100,
                                          child: Obx(
                                            () => AnimatedOpacity(
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              opacity: isPauseAnimation.value
                                                  ? 1
                                                  : 0,
                                              child: IconButton(
                                                onPressed: () {
                                                  isPauseAnimation.value = true;
                                                  _controller!.play();
                                                },
                                                icon: isPauseAnimation.value
                                                    ? Icon(
                                                        Icons.play_arrow,
                                                        color: Colors.white,
                                                        size: 60,
                                                      )
                                                    : Icon(
                                                        Icons.pause,
                                                        color: Colors.white,
                                                        size: 60,
                                                      ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                  ])
                ],
              ),
            ),
            Container(
              height: 2,
              color: Colors.black45,
            ),
            SizedBox(
              height: 10,
            ),

            TextField(
              controller: _location,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: 'Add location',
                  labelText: 'Location',
                  labelStyle: TextStyle(color: Colors.black45),
                  hintStyle: TextStyle(color: Colors.black45),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent))),
              autofocus: true,
            ),
            Container(
              height: 2,
              color: Colors.black45,
            ),

            // ImageSlider(listofImage: args['postimage']!),
          ],
        ),
      ),
    );
  }
}
