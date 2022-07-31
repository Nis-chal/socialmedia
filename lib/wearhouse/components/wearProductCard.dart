import 'package:flutter/material.dart';
import 'package:socialmedia/components/like_animation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:socialmedia/utils/url.dart';
import 'package:get/get.dart';
import 'dart:math';

class WearPostCard extends StatefulWidget {
  @override
  State<WearPostCard> createState() => _WearPostCardState();
  String? username, description, date, address, userimage;
  int? likecount;
  List<String>? image;
  WearPostCard({
    this.image,
    this.username,
    this.description,
    this.date,
    this.address,
    this.userimage,
    this.likecount,
  });
}

class _WearPostCardState extends State<WearPostCard> {
  Random random = Random();
  int commentLen = 0;
  bool isLikeAnimating = false;
  var liked = false.obs;
  RxInt likecount = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: Colors.black,
        // ),

        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundImage: NetworkImage(
                    '$baseUr${widget.userimage!}',
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.username ?? 'username',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10),
                        ),
                        Text(
                          widget.username ?? 'username',
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 5),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      useRootNavigator: false,
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: ListView(
                              shrinkWrap: true,
                              children: [
                                'Delete',
                              ]
                                  .map(
                                    (e) => InkWell(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          child: Text(e),
                                        ),
                                        onTap: () {
                                          // remove the dialog box
                                          Navigator.of(context).pop();
                                        }),
                                  )
                                  .toList()),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.more_vert,
                    size: 10,
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () {
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 16 / 9,
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                    ),
                    items: widget.image!.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(color: Colors.amber),
                            child: Image.network(
                              '$baseUr$i',
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isLikeAnimating ? 1 : 0,
                    child: LikeAnimation(
                      isAnimating: isLikeAnimating,
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 10,
                      ),
                      duration: const Duration(
                        milliseconds: 400,
                      ),
                      onEnd: () {
                        setState(() {
                          isLikeAnimating = false;
                          liked.value = !liked.value;
                          if (liked.value) {
                            likecount++;
                          } else {
                            likecount--;
                          }
                        });
                      },
                    ),
                  ),
                  Positioned(
                    top: -10,
                    right: -10,
                    child: LikeAnimation(
                      isAnimating: false,
                      smallLike: true,
                      child: IconButton(
                        icon: liked.value
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 10,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                size: 10,
                              ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // LIKE, COMMENT SECTION OF THE POST

          //DESCRIPTION AND NUMBER OF COMMENTS
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                    height: 10,
                    child: Obx(
                      () => Text(
                        '$likecount likes',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                    )),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 2,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: '${widget.username}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10),
                        ),
                        TextSpan(
                          text: ' ${widget.description}',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
