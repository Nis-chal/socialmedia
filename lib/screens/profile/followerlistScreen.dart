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
  String profileusername;
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
      this.profileusername,
      {Key? key})
      : super(key: key);

  @override
  State<Followerlist> createState() => _FollowerlistState();
}

class _FollowerlistState extends State<Followerlist> {
  PageController? controller;
  RxBool isedit = false.obs;
  RxInt activeTab = 0.obs;

  @override
  void initState() {
    activeTab.value = widget.initialpage;
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
    return Column(
      children: [
        Container(
          height: 45,
          child: Row(children: [
            IconButton(
                onPressed: widget.backoption, icon: Icon(Icons.arrow_back_ios)),
            Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.31, top: 10),
                child: Text(
                  widget.profileusername,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ))
          ]),
        ),
        Container(
          height: 50,
          child: Row(
            children: [
              Obx(
                () => Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: activeTab.value == 0
                          ? const Border(
                              bottom: BorderSide(color: Colors.black87))
                          : const Border(
                              bottom: BorderSide(color: Colors.transparent)),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          activeTab.value = 0;

                          controller!.animateToPage(0,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                          onPrimary:
                              activeTab == 0 ? Colors.black87 : Colors.black45,
                        ),
                        child: const Text(
                          'Followers',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ),
              Obx(
                () => Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: activeTab.value == 1
                          ? const Border(
                              bottom: BorderSide(color: Colors.black87))
                          : const Border(
                              bottom: BorderSide(color: Colors.transparent)),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          activeTab.value = 1;

                          controller!.animateToPage(1,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                          // ignore: unrelated_type_equality_checks
                          onPrimary: activeTab.value == 1
                              ? Colors.black87
                              : Colors.black45,
                        ),
                        child: const Text(
                          'Following',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: PageView(
              controller: controller,
              onPageChanged: (value) {
                activeTab.value = value;
              },
              children: [
                FutureBuilder<ProfileResponse?>(
                    future: ProfileRepository().userProfile(widget.profileid),
                    builder: (((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data != null) {
                          ProfileResponse? profile = snapshot.data!;
                          return Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                    itemCount: profile.followers!.length,
                                    itemBuilder: (context, index) {
                                      return Follower(
                                        profile.followers![index].username!,
                                        profile
                                            .followers![index].profilePicture!,
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
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
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
                              Expanded(
                                child: ListView.builder(
                                  itemCount: profile.followings!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Following(
                                            profile
                                                .followings![index].username!,
                                            profile.followings![index]
                                                .profilePicture!,
                                            profile.followings![index].id!,
                                            widget.userid,
                                            isedit.value,
                                            widget.increasefollowing,
                                            widget.decreasefollowing));
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
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        );
                      }
                    }))),
              ]),
        ),
      ],
    );
  }
}
