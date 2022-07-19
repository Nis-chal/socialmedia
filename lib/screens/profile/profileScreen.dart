import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/components/FollowButton.dart';
import 'package:socialmedia/models/User.dart';
import 'package:socialmedia/repository/PostRepository.dart';
import 'package:socialmedia/repository/ProfileRepository.dart';
import 'package:socialmedia/response/profileResponse/ProfileResponse.dart';
import 'package:socialmedia/screens/profile/editProfile.dart';
import 'package:socialmedia/utils/url.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profieScreen_id';
  final String? arguments;

  ProfileScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  RxBool isFollowing = false.obs;
  RxString userid = ''.obs;
  RxInt activeTab = 0.obs;
  RxInt followercount = 0.obs;
  RxInt followingcount = 0.obs;

  @override
  void initState() {
    _loadCounter();
    super.initState();
  }

  // @override
  // void dispose() {
  //   _loadCounter();
  //   super.dispose();
  // }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = (prefs.getString('userdata') ?? '');
    var userdatas = User.fromJson(jsonDecode(data.toString()));
    ProfileRepository profileRepository = ProfileRepository();
    ProfileResponse? profileInfo =
        await profileRepository.userProfile(widget.arguments!);

    setState(() {
      var id = userdatas.id.toString();
      var follower = profileInfo!.user.followers!;

      userid.value = userdatas.id.toString();

      isFollowing.value = follower.contains(id) ? true : false;
      followercount.value = follower.length;
      followingcount.value = profileInfo.user.following!.length;
    });

    // if (profileInfo!.followers!.length! > 0) {
    //   for (int i = 0; i < profileInfo!.followers!.length; i++) {
    //     if (profileInfo.followers[i].id == userdatas.id.toString()) {
    //       isFollowing.value = true;
    //     }
    //   }
    // }
  }

  _followUser(String id) async {
    try {
      ProfileRepository profileRepository = ProfileRepository();
      bool? isfollowed = await profileRepository.followuser(id);
      if (isfollowed!) {
        isFollowing.value = true;
        followercount++;
      }
    } catch (e) {}
  }

  _unfollowUser(String id) async {
    try {
      ProfileRepository profileRepository = ProfileRepository();
      bool? unfollowed = await profileRepository.unfollowuser(id);
      if (unfollowed!) {
        isFollowing.value = false;
        followercount--;
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder<ProfileResponse?>(
        future: ProfileRepository().userProfile(widget.arguments!),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              ProfileResponse? profile = snapshot.data!;
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.02,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          Text(
                            profile.user.username!.toUpperCase(),
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.06,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(
                              baseUr + profile.user.profilePicture!),
                          radius: 40,
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildStatColumn(
                                      profile.post!.length, "posts"),
                                  Obx(
                                    () => buildStatColumn(
                                        followercount.value, "followers"),
                                  ),
                                  Obx(
                                    () => buildStatColumn(
                                        followingcount.value, "following"),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        userid.value == widget.arguments
                            ? Expanded(
                                child: FollowButton(
                                    text: 'Edit Profile',
                                    backgroundColor: Color(0XFFEFEFEF),
                                    textColor: Colors.black87,
                                    borderColor: Colors.transparent,
                                    function: () {
                                      Navigator.pushNamed(
                                          context, EditProfileScreen.id,
                                          arguments: {
                                            "id": profile.user.id,
                                            "username": profile.user.username,
                                            "name": profile.user.name,
                                            "location": profile.user.location,
                                            "profilePicture":
                                                profile.user.profilePicture,
                                            "email": profile.user.email,
                                          });
                                    }),
                              )
                            : Obx(
                                () => isFollowing.value
                                    ? Expanded(
                                        child: FollowButton(
                                            text: 'Unfollow',
                                            backgroundColor: Colors.white,
                                            textColor: isFollowing.value
                                                ? Colors.black
                                                : Colors.white,
                                            borderColor: isFollowing.value
                                                ? Colors.grey
                                                : Colors.blue,
                                            function: () {
                                              isFollowing.value
                                                  ? _unfollowUser(
                                                      profile.user.id!)
                                                  : _followUser(
                                                      profile.user.id!);
                                            }),
                                      )
                                    : Expanded(
                                        child: FollowButton(
                                            text: !isFollowing.value
                                                ? 'Follow'
                                                : 'UnFollow',
                                            backgroundColor: !isFollowing.value
                                                ? Colors.blue
                                                : Colors.white,
                                            textColor: !isFollowing.value
                                                ? Colors.white
                                                : Colors.black,
                                            borderColor: !isFollowing.value
                                                ? Colors.blue
                                                : Colors.grey,
                                            function: () {
                                              isFollowing.value
                                                  ? _unfollowUser(
                                                      profile.user.id!)
                                                  : _followUser(
                                                      profile.user.id!);
                                            }),
                                      ),
                              ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Icon(
                            Icons.verified_user_sharp,
                            color: Colors.black45,
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: const Color(0XFFEFEFEF)),
                        )
                      ],
                    ),
                    Positioned(
                      top: 50,
                      child: Row(
                        children: [
                          Obx(
                            () => Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: activeTab.value == 0
                                      ? const Border(
                                          bottom:
                                              BorderSide(color: Colors.black87))
                                      : const Border(
                                          bottom: BorderSide(
                                              color: Colors.transparent)),
                                ),
                                child: ElevatedButton(
                                    onPressed: () {
                                      activeTab.value = 0;
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      onPrimary: activeTab == 0
                                          ? Colors.black87
                                          : Colors.black45,
                                    ),
                                    child: const Icon(Icons.apps)),
                              ),
                            ),
                          ),
                          Obx(
                            () => Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: activeTab.value == 1
                                      ? const Border(
                                          bottom:
                                              BorderSide(color: Colors.black87))
                                      : const Border(
                                          bottom: BorderSide(
                                              color: Colors.transparent)),
                                ),
                                child: ElevatedButton(
                                    onPressed: () {
                                      activeTab.value = 1;
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      // ignore: unrelated_type_equality_checks
                                      onPrimary: activeTab == 1
                                          ? Colors.black87
                                          : Colors.black45,
                                    ),
                                    child: const Icon(Icons.photo_album)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 2.0,
                                  mainAxisSpacing: 4.0),
                          itemCount: profile.post!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(
                              '$baseUr${profile.post![index].images![1]}',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text("No data"),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          }
        }),
      )),
    );
  }

  Column buildStatColumn(int value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
