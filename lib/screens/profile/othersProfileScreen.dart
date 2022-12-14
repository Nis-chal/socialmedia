import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/components/FollowButton.dart';
import 'package:socialmedia/components/post_cardv2.dart';
import 'package:socialmedia/models/Posts.dart';
import 'package:socialmedia/models/User.dart';
import 'package:socialmedia/repository/PostRepository.dart';
import 'package:socialmedia/repository/ProfileRepository.dart';
import 'package:socialmedia/response/FeedsResponse.dart';
import 'package:socialmedia/response/profileResponse/ProfileResponse.dart';
import 'package:socialmedia/responsive/navigation_drawer.dart';
import 'package:socialmedia/screens/profile/editProfile.dart';
import 'package:socialmedia/screens/profile/followerlistScreen.dart';
import 'package:socialmedia/utils/url.dart';

class OtherProfileScreen extends StatefulWidget {
  static const String id = 'profieScreen_id';
  final String? arguments;
  final VoidCallback? goback;

  OtherProfileScreen({Key? key, this.arguments, this.goback}) : super(key: key);

  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  RxBool isFollowing = false.obs;
  RxString userid = ''.obs;
  RxInt activeTab = 0.obs;
  RxInt followercount = 0.obs;
  RxInt followingcount = 0.obs;
  RxString profileuserid = ''.obs;

  RxInt initfollowerCount = 0.obs;
  RxInt followingpage = 0.obs;
  RxString profileUsername = ''.obs;

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

    var id = userdatas.id.toString();
    var follower = profileInfo!.user.followers!;

    userid.value = userdatas.id.toString();

    isFollowing.value = follower.contains(id) ? true : false;
    followercount.value = follower.length;
    followingcount.value = profileInfo.user.following!.length;
    initfollowerCount.value = profileInfo.user.following!.length;
    profileuserid.value =
        userdatas.id! == widget.arguments! ? userdatas.id! : widget.arguments!;

    profileUsername.value = profileInfo.user.username!;

    // if (profileInfo!.followers!.length! > 0) {
    //   for (int i = 0; i < profileInfo!.followers!.length; i++) {
    //     if (profileInfo.followers[i].id == userdatas.id.toString()) {
    //       isFollowing.value = true;
    //     }
    //   }
    // }
  }

  _decreasefollower() {
    followercount--;
  }

  _increasefollower() {
    followercount++;
  }

  _decreasefollowing() {
    followingcount--;
  }

  _increasefollowing() {
    followingcount++;
  }

  _goback() {
    sliderContoller.jumpToPage(0);
  }

  _followUser(String id) async {
    try {
      ProfileRepository profileRepository = ProfileRepository();
      bool? isfollowed = await profileRepository.followuser(id);
      if (isfollowed!) {
        isFollowing.value = true;
        _increasefollower();
      }
    } catch (e) {}
  }

  _unfollowUser(String id) async {
    try {
      ProfileRepository profileRepository = ProfileRepository();
      bool? unfollowed = await profileRepository.unfollowuser(id);
      if (unfollowed!) {
        isFollowing.value = false;
        _decreasefollower();
      }
    } catch (e) {}
  }

  Widget buildImage(Posts post, int index) => Container(
      color: Colors.white,
      child: PostCardV2(
        id: post.id,
        username: post.userid!.username!,
        image: post.images,
        date: post.createdAt,
        address: post.location,
        description: post.description,
        userimage: post.userid!.profilePicture,
        likesid: post.likesid,
        commentsid: post.commentsid,
        updatedAt: post.updatedAt,
        createdAt: post.createdAt,
        saved: post.saved,
      ));

  final contoller = PageController(initialPage: 0);
  final sliderContoller = PageController(initialPage: 0);
  RxList feedlist = [].obs;
  RxList likedlist = [].obs;

  RxList sliderlist = [].obs;

  RxInt currentPage = 0.obs;
  List<Posts> sliderpost = [];
  RxString currentUser = ''.obs;
  Map? profilemap;

  final carouselcontoller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: PageView(controller: sliderContoller, children: [
        FutureBuilder<ProfileResponse?>(
          future: ProfileRepository().userProfile(widget.arguments!),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                ProfileResponse? profile = snapshot.data!;
                feedlist.value = profile.post!;
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.02,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, NavigationDrawer.id, arguments: {
                                    "pageIndex": 1,
                                    "profilePicture": null,
                                    "profileId": "",
                                    "isProfile": 0
                                  });
                                },
                                icon: const Icon(Icons.arrow_back_ios_new)),
                            SizedBox(
                              width: 20,
                            ),
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
                                      () => GestureDetector(
                                        onTap: () {
                                          followingpage.value = 0;
                                          sliderContoller.jumpToPage(2);
                                        },
                                        child: buildStatColumn(
                                            followercount.value, "followers"),
                                      ),
                                    ),
                                    Obx(
                                      () => GestureDetector(
                                        onTap: () {
                                          followingpage.value = 1;
                                          sliderContoller.jumpToPage(2);
                                        },
                                        child: buildStatColumn(
                                            followingcount.value, "following"),
                                      ),
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

                                                AwesomeNotifications()
                                                    .createNotification(
                                                        content: NotificationContent(
                                                            channelKey:
                                                                'basic_channel',
                                                            title: 'Followed',
                                                            body:
                                                                "${profile.user.username}",
                                                            id: 1));
                                              }),
                                        )
                                      : Expanded(
                                          child: FollowButton(
                                              text: !isFollowing.value
                                                  ? 'Follow'
                                                  : 'UnFollow',
                                              backgroundColor:
                                                  !isFollowing.value
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
                      Row(
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
                                      sliderlist = feedlist;
                                      contoller.animateToPage(0,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeIn);
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
                                      sliderlist = likedlist;

                                      contoller.animateToPage(1,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeIn);
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: PageView(
                              controller: contoller,
                              onPageChanged: (value) {
                                activeTab.value = value;
                              },
                              // physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: [
                                GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 2.0,
                                          mainAxisSpacing: 4.0),
                                  itemCount: profile.post!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        currentPage.value = index;
                                        sliderlist = feedlist;

                                        sliderContoller.animateToPage(1,
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.easeIn);
                                      },
                                      child: Image.network(
                                        '$baseUr${profile.post![index].images![0]}',
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                ),
                                FutureBuilder<FeedsResponse?>(
                                  future: PostRepository()
                                      .likedfeeds(widget.arguments!),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.data != null) {
                                        // ProductResponse productResponse = snapshot.data!;
                                        List<Posts> postlst =
                                            snapshot.data!.posts!;

                                        likedlist.value = postlst;

                                        return GridView.builder(
                                            itemCount: postlst.length,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    crossAxisSpacing: 2.0,
                                                    mainAxisSpacing: 4.0),
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  currentPage.value = index;
                                                  sliderlist = likedlist;
                                                  sliderContoller.animateToPage(
                                                      1,
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.easeIn);
                                                },
                                                child: Image.network(
                                                  '$baseUr${postlst[index].images![0]}',
                                                  fit: BoxFit.cover,
                                                ),
                                              );
                                            });
                                      } else {
                                        return const Center(
                                          child: Text("No data"),
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
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.blue),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ]),
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
        ),
        Obx(
          () => Column(
            children: [
              Container(
                color: Colors.white,
                height: 50,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Obx(
                      () => activeTab.value == 0
                          ? IconButton(
                              onPressed: () {
                                sliderContoller.animateToPage(0,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              },
                              icon: Icon(Icons.arrow_back_ios_new))
                          : IconButton(
                              onPressed: () {
                                activeTab.value = 0;
                                // contoller.animateToPage(1,
                                //     duration: Duration(milliseconds: 500),
                                //     curve: Curves.easeIn);
                                sliderContoller.animateToPage(0,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              },
                              icon: Icon(Icons.arrow_back_ios_new)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.31,
                          top: 10),
                      child: Column(
                        children: [
                          Text(
                            sliderlist[0].userid.username,
                            style:
                                TextStyle(fontSize: 15, color: Colors.black45),
                          ),
                          Obx(() => activeTab.value == 0
                              ? Text(
                                  'Posts',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )
                              : Text('Liked Posts',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15))),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: CarouselSlider.builder(
                  carouselController: carouselcontoller,
                  itemCount: sliderlist.length,
                  options: CarouselOptions(
                    scrollDirection: Axis.vertical,
                    initialPage: currentPage.value,
                    height: MediaQuery.of(context).size.height,

                    // pageSnapping: false,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) => currentPage.value = index,
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final urlImage = sliderlist[index];
                    return buildImage(urlImage, index);
                  },
                ),
              ),
            ],
          ),
        ),
        Obx(() => Followerlist(
              widget.arguments!,
              _decreasefollower,
              followercount.value,
              followingpage.value,
              sliderContoller,
              _goback,
              userid.value,
              _increasefollowing,
              _decreasefollowing,
              profileUsername.value,
            )),
      ])),
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
