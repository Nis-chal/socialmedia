import 'package:flutter/material.dart';
import 'package:socialmedia/repository/ProfileRepository.dart';
import 'package:socialmedia/response/profileResponse/ProfileResponse.dart';

import '../../utils/url.dart';

class Followerlist extends StatefulWidget {
  final String profileid;
  VoidCallback decrease;
  VoidCallback increase;
  int followercount;
  int initialpage;
  Followerlist(this.profileid, this.decrease, this.increase, this.followercount,
      this.initialpage,
      {Key? key})
      : super(key: key);

  @override
  State<Followerlist> createState() => _FollowerlistState();
}

class _FollowerlistState extends State<Followerlist> {
  PageController? controller;

  @override
  void initState() {
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
                            onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
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
                        itemCount: profile.followers!.length,
                        itemBuilder: (context, index) {
                          return Row(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(baseUr +
                                    profile.followers![index].profilePicture!),
                              ),
                              Text(profile.followers![index].username!),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Remove'),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.grey,
                                    padding: EdgeInsets.symmetric(vertical: 4)),
                              )
                            ],
                          );
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
                            onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
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
                          return Row(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(baseUr +
                                    profile.followings![index].profilePicture!),
                              ),
                              Text(profile.followings![index].username!),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('unfollow'),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.grey,
                                    padding: EdgeInsets.symmetric(vertical: 4)),
                              )
                            ],
                          );
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
