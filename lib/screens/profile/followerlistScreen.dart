import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmedia/components/Follower.dart';
import 'package:socialmedia/components/Following.dart';
import 'package:socialmedia/repository/ProfileRepository.dart';
import 'package:socialmedia/response/profileResponse/ProfileResponse.dart';

import '../../utils/url.dart';

class Followerlist extends StatefulWidget {
  final String profileid;
  VoidCallback decrease;
  int followercount;
  int initialpage;
  PageController contoller;
  VoidCallback backoption;
  String userid;
  VoidCallback increasefollowing;
  VoidCallback decreasefollowing;
  Followerlist(
      this.profileid,
      this.decrease,
      this.followercount,
      this.initialpage,
      this.contoller,
      this.backoption,
      this.userid,
      this.increasefollowing,
      this.decreasefollowing,
      {Key? key})
      : super(key: key);

  @override
  State<Followerlist> createState() => _FollowerlistState();
}

class _FollowerlistState extends State<Followerlist> {
  PageController? controller;
  RxBool isedit = false.obs;

  @override
  void initState() {
    isedit.value = widget.profileid == widget.userid ? true : false;

    super.initState();
    controller = PageController(initialPage: widget.initialpage);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(controller: controller, children: [
      FutureBuilder<ProfileResponse?>(
          future: ProfileRepository().userProfile(widget.profileid),
          builder: (((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                ProfileResponse? profile = snapshot.data!;
                return Column(
                  children: [
                    Container(
                      height: 45,
                      child: Row(children: [
                        IconButton(
                            onPressed: widget.backoption,
                            icon: Icon(Icons.arrow_back_ios)),
                        Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.31,
                                top: 10),
                            child: Text(
                              profile.user.username!,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ))
                      ]),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: profile.followers!.length,
                          itemBuilder: (context, index) {
                            return Follower(
                              profile.followers![index].username!,
                              profile.followers![index].profilePicture!,
                              profile.followers![index].id!,
                              widget.userid,
                              isedit.value,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('No data'),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              );
            }
          }))),
      FutureBuilder<ProfileResponse?>(
          future: ProfileRepository().userProfile(widget.profileid),
          builder: (((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                ProfileResponse? profile = snapshot.data!;
                return Column(
                  children: [
                    Container(
                      height: 45,
                      child: Row(children: [
                        IconButton(
                            onPressed: widget.backoption,
                            icon: Icon(Icons.arrow_back_ios)),
                        Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.31,
                                top: 10),
                            child: Text(
                              profile.user.username!,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ))
                      ]),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: profile.followings!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Following(
                                profile.followings![index].username!,
                                profile.followings![index].profilePicture!,
                                profile.followings![index].id!,
                                widget.userid,
                                isedit.value,
                                widget.increasefollowing,
                                widget.decreasefollowing
                              ));
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('No data'),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              );
            }
          }))),
    ]);
  }
}
