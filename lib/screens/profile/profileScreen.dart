import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/components/FollowButton.dart';
import 'package:socialmedia/components/post_card.dart';
import 'package:socialmedia/components/post_cardv2.dart';
import 'package:socialmedia/models/Posts.dart';
import 'package:socialmedia/models/User.dart';
import 'package:socialmedia/repository/PostRepository.dart';
import 'package:socialmedia/repository/ProfileRepository.dart';
import 'package:socialmedia/response/FeedsResponse.dart';
import 'package:socialmedia/response/profileResponse/ProfileResponse.dart';
import 'package:socialmedia/screens/profile/editProfile.dart';
import 'package:socialmedia/screens/profile/followerlistScreen.dart';
import 'package:socialmedia/screens/profile/profileSliderScreen.dart';
import 'package:socialmedia/screens/shorts/Addshort.dart';
import 'package:socialmedia/utils/url.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profieScreen_id';
  final String? arguments;
  final VoidCallback? goback;

  ProfileScreen({Key? key, this.arguments, this.goback}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  RxBool isFollowing = false.obs;
  RxString userid = ''.obs;
  RxInt activeTab = 0.obs;
  RxInt followercount = 0.obs;
  RxInt followingcount = 0.obs;
  RxString profileuserid = ''.obs;

  RxInt initfollowerCount = 0.obs;
  RxInt followingpage = 0.obs;
  RxString profileUsername = ''.obs;
  RxString profilePicture = ''.obs;

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
      initfollowerCount.value = profileInfo.user.following!.length;
      profileuserid.value = userdatas.id! == widget.arguments!
          ? userdatas.id!
          : widget.arguments!;

      profileUsername.value = profileInfo.user.username!;
      profilePicture.value = userdatas.profilePicture!;
    });

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

  File? fimage;
  RxBool loaded = false.obs;

  Future _loadShort(ImageSource mediaSource) async {
    try {
      final image = await ImagePicker().pickVideo(source: mediaSource);
      if (image != null) {
        fimage = File(image.path);
        loaded.value = true;
      } else {
        return;
      }
    } catch (e) {
      debugPrint('Failed to pick Image $e');
    }
    Navigator.pushNamed(context, AddShortScreen.id, arguments:fimage);
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

  Widget changeVideo({required VoidCallback onpop}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 150,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        textDirection: TextDirection.rtl,
        children: [
          GestureDetector(
            onTap: () {
              _loadShort(ImageSource.camera);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              height: 40,
              child: Center(child: Text('Capture Shorts')),
            ),
          ),
          GestureDetector(
            onTap: () {
              _loadShort(ImageSource.gallery);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              height: 40,
              child: Center(child: Text('Choose From Gallery')),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: onpop,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(9))),
              height: 40,
              child: const Center(child: Text('cancel')),
            ),
          ),
        ],
      ),
    );
  }

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
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              profile.user.username!.toUpperCase(),
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (BuildContext context) =>
                                        changeVideo(
                                      onpop: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(Icons.add_box_outlined))
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
