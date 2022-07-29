import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../utils/url.dart';
import 'package:timeago/timeago.dart ' as timeago;
import 'package:socialmedia/repository/ShortsRepository.dart';

class VideoPlayerWidg extends StatefulWidget {
  String url;
  String profilePicture, username, description, createdBy, loginuserid;
  String? location, id;
  DateTime createdAt;
  List? likes, dislikes;
  VideoPlayerWidg(
      {this.id,
      required this.url,
      required this.profilePicture,
      required this.username,
      required this.description,
      this.location,
      required this.createdAt,
      required this.createdBy,
      required this.loginuserid,
      this.likes,
      this.dislikes,
      Key? key})
      : super(key: key);

  @override
  State<VideoPlayerWidg> createState() => _VideoPlayerWidgState();
}

class _VideoPlayerWidgState extends State<VideoPlayerWidg> {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  RxBool toggleOption = false.obs;
  RxBool islike = false.obs;
  RxBool isdislike = false.obs;
  RxBool isPauseAnimation = false.obs;

  @override
  void initState() {
    _controller = VideoPlayerController.network(baseUr + widget.url)
      ..setLooping(true)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller!.play();
        });
      });

    if (widget.likes!.contains(widget.loginuserid)) {
      islike.value = true;
    }

    if (widget.dislikes!.contains(widget.loginuserid)) {
      isdislike.value = true;
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  _unlike() {
    islike.value = false;
  }

  _undislike() {
    isdislike.value = false;
  }

  _likeshorts() async {
    bool short = await ShortsRepository().likeShort(widget.id!);

    if (short) {
      if (isdislike.value) {
        isdislike.value = false;
      }
      islike.value = true;
    }
  }

  _dislikeshorts() {
    if (islike.value) {
      islike.value = false;
    }
    isdislike.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isPauseAnimation.value = !isPauseAnimation.value;
        if (isPauseAnimation.value) {
          _controller!.pause();
        } else {
          _controller!.play();
        }
      },
      child: Container(
          child: _controller!.value.isInitialized
              ? Stack(children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(_controller!),
                    ),
                  ),
                  Positioned(
                    top: 300,
                    right: 10,
                    child: Column(
                      children: [
                        Obx(
                          () => islike.value
                              ? IconButton(
                                  onPressed: () {
                                    _unlike();
                                  },
                                  icon: Icon(
                                    Icons.thumb_up_alt_sharp,
                                    color: Colors.blueAccent,
                                    size: 30,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    _likeshorts();
                                  },
                                  icon: Icon(
                                    Icons.thumb_up_alt_sharp,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Obx(() => !isdislike.value
                            ? IconButton(
                                onPressed: () {
                                  _dislikeshorts();
                                },
                                icon: Icon(
                                  Icons.thumb_down,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  _undislike();
                                },
                                icon: Icon(
                                  Icons.thumb_down,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                              )),
                        SizedBox(
                          height: 20,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.bookmark_add_sharp,
                            color: Colors.white,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 120,
                    left: 20,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(baseUr + widget.profilePicture),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.username,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          timeago.format(widget.createdAt),
                          style: TextStyle(
                            color: Colors.white54,
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      left: 20,
                      bottom: 90,
                      child: Text(
                        widget.description,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      )),
                  Positioned(
                      top: 10,
                      right: 10,
                      child: Visibility(
                        visible: widget.loginuserid == widget.createdBy
                            ? true
                            : false,
                        child: IconButton(
                          onPressed: () {
                            toggleOption.value = !toggleOption.value;
                          },
                          icon: Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          ),
                        ),
                      )),
                  Positioned(
                      top: 40,
                      right: 10,
                      child: Obx(() => Visibility(
                            visible: toggleOption.value ? true : false,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              color: Color.fromARGB(118, 22, 22, 22),
                              child: IconButton(
                                color: Colors.white,
                                onPressed: () {},
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ))),
                  Positioned(
                      top: 350,
                      left: 170,
                      child: Obx(() => AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: isPauseAnimation.value ? 1 : 0,
                            child: IconButton(
                              onPressed: () {},
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
                          )))
                ])
              : Container(
                  child: Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                  )),
                )),
    );
  }
}
