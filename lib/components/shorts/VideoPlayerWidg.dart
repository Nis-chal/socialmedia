import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../utils/url.dart';

class VideoPlayerWidg extends StatefulWidget {
  String url;
  String profilePicture, username, description;
  String? location;
  VideoPlayerWidg(
      {required this.url,
      required this.profilePicture,
      required this.username,
      required this.description,
      this.location,
      Key? key})
      : super(key: key);

  @override
  State<VideoPlayerWidg> createState() => _VideoPlayerWidgState();
}

class _VideoPlayerWidgState extends State<VideoPlayerWidg> {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(baseUr + widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller!.play();
        });
      });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.thumb_up_alt_sharp,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.thumb_down,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
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
                  bottom: 180,
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
                      )
                    ],
                  ),
                )
              ])
            : Container(
                child: Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                )),
              ));
  }
}
