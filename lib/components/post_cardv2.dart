import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socialmedia/components/explorepageSlider.dart';
import './like_animation.dart';
import '../utils/url.dart';
import 'package:socialmedia/screens/ImageSlider.dart';
import 'package:socialmedia/components/bottom_sheet.dart';

import 'package:timeago/timeago.dart ' as timeago;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/models/User.dart';
import 'package:socialmedia/repository/PostRepository.dart';
import 'package:socialmedia/screens/post/post_edit.dart';

class PostCardV2 extends StatefulWidget {
  @override
  State<PostCardV2> createState() => _PostCardV2State();
  String? username, description, address, userimage, updatedAt, id, postUserId;
  List<String>? image, likesid, commentsid, saved;
  DateTime? createdAt, date;
  String? userProfileId;
  VoidCallback? navigateTo;
  VoidCallback? navigateBack;

  PostCardV2({
    this.id,
    this.image,
    this.username,
    this.description,
    this.date,
    this.address,
    this.userimage,
    this.likesid,
    this.commentsid,
    this.saved,
    this.updatedAt,
    this.createdAt,
    this.userProfileId,
    this.navigateTo,
    this.navigateBack,
    this.postUserId,
  });
}

class _PostCardV2State extends State<PostCardV2> {
  int commentLen = 0;
  var isLikeAnimating = false.obs;
  var liked = false.obs;
  var userliked = false;
  late var likeslist = widget.likesid;

  late List<String>? saveList = widget.saved;
  RxBool userSaved = false.obs;

  RxBool isDelete = true.obs;

  var userid = ''.obs;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      var data = (prefs.getString('userdata') ?? '');
      var userdatas = User.fromJson(jsonDecode(data.toString()));
      var userid = userdatas.id.toString();

      liked.value = likeslist!.contains(userid) ? true : false;
      userSaved.value = saveList!.contains(userid) ? true : false;

      // if(likeslist!.contains(userid)){
      //   liked.value = true;

      // }

      // if(saveList!.contains(userid)){
      //   userSaved.value = true;

      // }
    });
  }

  late var likelength = widget.likesid!.length.obs;

  void increament() {
    PostRepository().likePost(widget.id);

    likelength++;
    liked.value = true;
  }

  void _savePost() async {
    bool post = await PostRepository().savePost(widget.id);
    if (post) {
      userSaved.value = true;
    }
  }

  void _unsavePost() async {
    bool post = await PostRepository().unsavePost(widget.id);
    if (post) {
      userSaved.value = false;
    }
  }

  saveandunsave() {
    !userSaved.value ? _savePost() : _unsavePost();
  }

  likeandunlike() {
    if (liked.isTrue) {
      PostRepository().unlikePost(widget.id);

      likelength--;
      liked.value = false;
    } else {
      increament();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Visibility(
          visible: isDelete.value,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              // border: Border.all(
              //   color: Colors.black,
              // ),
              boxShadow: [
                isDelete.isTrue
                    ? BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(0, 3), // changes position of shadow
                      )
                    : const BoxShadow(
                        color: Colors.transparent,
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset: Offset(0, 0)),
              ],
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 16,
                  ).copyWith(right: 0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(
                          '$baseUr${widget.userimage!}',
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.username ?? 'username',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Visibility(
                                  visible:
                                      widget.address != null ? true : false,
                                  child: Text(widget.address ?? '')),
                            ],
                          ),
                        ),
                      ),
                      BottomTab(
                        onDelete: () async {
                          bool post =
                              await PostRepository().deletePost(widget.id);
                          if (post) {
                            isDelete.value = false;
                            Navigator.pop(context);
                          }

                          // Navigator.push(context, MaterialPageRoute(builder: (context) => const SecondRoute()))
                        },
                        likeStatus: liked.value,
                        location: widget.address,
                        images: widget.image,
                        username: widget.username,
                        userimage: widget.userimage!,
                        description: widget.description,
                        postuser: widget.postUserId,
                        supost: saveandunsave,
                        likeunlike: likeandunlike,
                        savestatus: userSaved.value,
                        postid: widget.id,
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onDoubleTap: () {
                    isLikeAnimating.value = true;
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      //                 CarouselSlider(
                      //   options: CarouselOptions(
                      //     height: MediaQuery.of(context).size.height * 0.55,
                      //                 aspectRatio: 2.0,
                      //                 enlargeCenterPage: true,
                      //                 viewportFraction: 1,),
                      //   items: widget.image!.map((i) {
                      //     return Builder(
                      //       builder: (BuildContext context) {
                      //         return Container(
                      //           width: MediaQuery.of(context).size.width,
                      //           margin: EdgeInsets.symmetric(horizontal: 5.0),
                      //           decoration: BoxDecoration(
                      //             color: Colors.amber
                      //           ),
                      //           child: Image.network('$baseUr$i',fit: BoxFit.cover,),
                      //         );
                      //       },
                      //     );
                      //   }).toList(),
                      // ),
                      ExplorePageSlider(listofImage: widget.image),

                      Obx(
                        () => AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: isLikeAnimating.isTrue ? 1 : 0,
                          child: LikeAnimation(
                            isAnimating: isLikeAnimating.isTrue,
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 100,
                            ),
                            duration: const Duration(
                              milliseconds: 400,
                            ),
                            onEnd: () {
                              isLikeAnimating.value = false;

                              if (liked.isTrue) {
                                PostRepository().unlikePost(widget.id);

                                likelength--;
                                liked.value = false;
                              } else {
                                increament();
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // LIKE, COMMENT SECTION OF THE POST
                Row(
                  children: <Widget>[
                    LikeAnimation(
                        isAnimating: false,
                        smallLike: true,
                        child: Obx(
                          (() => IconButton(
                                icon: liked.value
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : const Icon(
                                        Icons.favorite_border,
                                      ),
                                onPressed: () {},
                              )),
                        )),
                    IconButton(
                        icon: const Icon(
                          Icons.comment_outlined,
                        ),
                        onPressed: () => {}),
                    IconButton(
                        icon: const Icon(
                          Icons.send,
                        ),
                        onPressed: () {}),
                    Expanded(
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Obx(
                              () => IconButton(
                                  icon: userSaved.value
                                      ? const Icon(Icons.bookmark_sharp)
                                      : const Icon(Icons.bookmark_border),
                                  onPressed: () {
                                    !userSaved.value
                                        ? _savePost()
                                        : _unsavePost();
                                  }),
                            )))
                  ],
                ),
                //DESCRIPTION AND NUMBER OF COMMENTS
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DefaultTextStyle(
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontWeight: FontWeight.w800),
                        child: Obx(
                          () => Text(
                            '$likelength likes',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: Visibility(
                          visible: widget.description != null ? true : false,
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: '${widget.username}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ${widget.description}',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                          child: Container(
                            child: Text(
                              'View all ${widget.commentsid?.length} comments',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 152, 149, 149),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 4),
                          ),
                          onTap: () {}),
                      Container(
                        child: Text(
                          timeago.format(widget.createdAt!),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 4),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
