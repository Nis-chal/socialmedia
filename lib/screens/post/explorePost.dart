import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmedia/components/post_card.dart';
import 'package:socialmedia/components/post_cardv2.dart';
import 'package:socialmedia/models/Posts.dart';
import 'package:socialmedia/models/User.dart';
import 'package:socialmedia/repository/PostRepository.dart';
import 'package:socialmedia/repository/ProfileRepository.dart';
import 'package:socialmedia/response/postResponse/ExplorePostResponse.dart';
import 'package:socialmedia/response/profileResponse/ProfileSearchResponse.dart';
import 'package:socialmedia/screens/profile/othersProfileScreen.dart';
import 'package:socialmedia/screens/profile/profileScreen.dart';
import 'package:socialmedia/utils/url.dart';
import 'package:staggered_grid_view_flutter/staggered_grid_view_flutter.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class ExplorePost extends StatelessWidget {
  ExplorePost({Key? key}) : super(key: key);

  final search = TextEditingController().obs;
  RxBool issearch = true.obs;
  RxBool isview = true.obs;
  RxBool isexplore = false.obs;
  final controller = CarouselController();
  RxInt activeIndex = 0.obs;
  RxInt intialpost = 0.obs;
  RxString searchvalue = "".obs;
  RxString profileid = "".obs;
  RxBool isloading = false.obs;

  final searchcontoller = PageController(initialPage: 0);

  final contoller = PageController(initialPage: 0);

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
  void animateToSlide(int index) => controller.jumpToPage(index);

  animateToSlide1() {
    contoller.jumpToPage(0);
  }

  isprofileid(String id) {
    profileid.value = id;
    contoller.animateToPage(
      2,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: contoller,
              children: [
                FutureBuilder<ExplorePostResponse?>(
                  future: PostRepository().exploreFeeds(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data != null) {
                        // ProductResponse productResponse = snapshot.data!;
                        List<Posts> postlst = snapshot.data!.posts!;

                        return Column(
                          children: [
                            Obx(
                              () => issearch.value
                                  ? GestureDetector(
                                      onTap: (() {
                                        isexplore.value = true;
                                      }),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 4),
                                              child: CupertinoSearchTextField(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                onChanged: (value) {
                                                  isexplore.value = true;
                                                  search.value.text = value;
                                                  searchvalue.value =
                                                      value.isEmpty
                                                          ? "0"
                                                          : value;
                                                  isloading.value =
                                                      !isloading.value;
                                                },
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible:
                                                isexplore.value ? true : false,
                                            child: GestureDetector(
                                              onTap: () {
                                                isexplore.value = false;
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0),
                                                child: Text(
                                                  'cancel',
                                                  style: TextStyle(
                                                      color:
                                                          Colors.blue.shade400,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(
                                      height: 25,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              isview.value = true;
                                              issearch.value = true;
                                            },
                                            icon: const Icon(
                                                Icons.arrow_back_ios),
                                            padding: const EdgeInsets.all(0),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3),
                                            child: const Text(
                                              'Explore',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                            ),
                            Obx(() {
                              return Visibility(
                                visible: isexplore.value ? true : false,
                                child: Obx(
                                  () => isloading.value
                                      ? FutureBuilder<ProfileSearchResponse?>(
                                          future: ProfileRepository()
                                              .profileSearch(search.value.text),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              if (snapshot.data != null) {
                                                List<User> userinfo =
                                                    snapshot.data!.users!;
                                                return SingleChildScrollView(
                                                  child: Container(
                                                      color: Colors.white,
                                                      height: 500 - 56,
                                                      child: ListView.builder(
                                                        itemCount:
                                                            userinfo.length,
                                                        itemBuilder:
                                                            ((context, index) {
                                                          return ElevatedButton(
                                                            onPressed: () {
                                                              profileid.value =
                                                                  userinfo[
                                                                          index]
                                                                      .id!;
                                                              contoller
                                                                  .animateToPage(
                                                                2,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            1),
                                                                curve: Curves
                                                                    .easeInOut,
                                                              );
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          2),
                                                              child: Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    backgroundImage:
                                                                        NetworkImage(
                                                                            '$baseUr${userinfo[index].profilePicture}'),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 4,
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      Text(
                                                                          userinfo[index]
                                                                              .username!,
                                                                          style:
                                                                              const TextStyle(fontWeight: FontWeight.bold)),
                                                                      Text(userinfo[
                                                                              index]
                                                                          .name!)
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                      )),
                                                );
                                              } else {
                                                return const Center(
                                                  child: Text("No data"),
                                                );
                                              }
                                            } else if (snapshot
                                                    .connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(Colors.blue),
                                                ),
                                              );
                                            }
                                          })
                                      : FutureBuilder<ProfileSearchResponse?>(
                                          future: ProfileRepository()
                                              .profileSearch(search.value.text),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              if (snapshot.data != null) {
                                                List<User> userinfo =
                                                    snapshot.data!.users!;
                                                return SingleChildScrollView(
                                                  child: Container(
                                                      color: Colors.white,
                                                      height: 500 - 56,
                                                      child: ListView.builder(
                                                        itemCount:
                                                            userinfo.length,
                                                        itemBuilder:
                                                            ((context, index) {
                                                          return ElevatedButton(
                                                            onPressed: () {
                                                              profileid.value =
                                                                  userinfo[
                                                                          index]
                                                                      .id!;
                                                              contoller
                                                                  .animateToPage(
                                                                2,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            1),
                                                                curve: Curves
                                                                    .easeInOut,
                                                              );
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          2),
                                                              child: Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    backgroundImage:
                                                                        NetworkImage(
                                                                            '$baseUr${userinfo[index].profilePicture}'),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 4,
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      Text(
                                                                          userinfo[index]
                                                                              .username!,
                                                                          style:
                                                                              const TextStyle(fontWeight: FontWeight.bold)),
                                                                      Text(userinfo[
                                                                              index]
                                                                          .name!)
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                      )),
                                                );
                                              } else {
                                                return const Center(
                                                  child: Text("No data"),
                                                );
                                              }
                                            } else if (snapshot
                                                    .connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(Colors.blue),
                                                ),
                                              );
                                            }
                                          }),
                                ),
                              );
                            }),
                            Obx(() {
                              return Expanded(
                                child: Visibility(
                                  visible: isview.value && !isexplore.value
                                      ? true
                                      : false,
                                  child: StaggeredGridView.countBuilder(
                                    staggeredTileBuilder: (index) =>
                                        index % 7 == 0
                                            ? const StaggeredTile.count(2, 2)
                                            : StaggeredTile.count(1, 1),
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 2.0,
                                    mainAxisSpacing: 4.0,
                                    itemCount: postlst.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: (() {
                                          isview.value = false;

                                          intialpost.value = index;
                                          issearch.value = false;
                                        }),
                                        child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              Image.network(
                                                '$baseUr${postlst[index].images![0]}',
                                                fit: BoxFit.cover,
                                              ),
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Visibility(
                                                    visible: postlst[index]
                                                                .images!
                                                                .length >
                                                            1
                                                        ? true
                                                        : false,
                                                    child: const Icon(
                                                      Icons.file_copy,
                                                      color: Colors.white70,
                                                    )),
                                              ),
                                            ]),
                                      );
                                    },
                                  ),
                                ),
                              );
                            }),
                            Obx(() => Visibility(
                                  visible: isview.value && issearch.value
                                      ? false
                                      : true,
                                  child: CarouselSlider.builder(
                                    carouselController: controller,
                                    itemCount: postlst.length,
                                    options: CarouselOptions(
                                      height: 720 - 53,
                                      initialPage: intialpost.value,

                                      scrollDirection: Axis.vertical,

                                      //  pageSnapping: false,
                                      enableInfiniteScroll: false,
                                      enlargeCenterPage: true,
                                      viewportFraction: 1,
                                      onPageChanged: (index, reason) =>
                                          activeIndex.value = index,
                                    ),
                                    itemBuilder: (context, index, realIndex) {
                                      final post = postlst[index];
                                      return buildImage(post, index);
                                    },
                                  ),
                                )),
                          ],
                        );
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
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      );
                    }
                  },
                ),
                Obx(() {
                  return OtherProfileScreen(
                    arguments: profileid.value,
                    goback: animateToSlide1,
                  );
                })
              ]),
        ),
      ),
    );
  }
}
