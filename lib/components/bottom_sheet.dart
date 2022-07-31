import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/constants.dart';
import 'package:socialmedia/models/User.dart';
import 'package:socialmedia/responsive/navigation_drawer.dart';
import 'package:socialmedia/screens/post/post_edit.dart';

class BottomTab extends StatefulWidget {
  String? postid, username, location, description, userimage, postuser;
  VoidCallback? onDelete;
  List<String>? images;
  VoidCallback? supost, likeunlike;
  bool? savestatus, likeStatus;

  BottomTab({
    Key? key,
    this.postid,
    this.onDelete,
    this.images,
    this.username,
    this.location,
    this.description,
    this.userimage,
    this.postuser,
    this.supost,
    this.savestatus,
    this.likeStatus,
    this.likeunlike,
  }) : super(key: key);

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  RxString loginuser = ''.obs;
  RxString loginuserPic = ''.obs;

  @override
  void initState() {
    _loadCounter();
    super.initState();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var data = (prefs.getString('userdata') ?? '');
    var userdatas = User.fromJson(jsonDecode(data.toString()));
    loginuser.value = userdatas.id.toString();
    loginuserPic.value = userdatas.profilePicture!;
  }

  Widget buildBottom({required VoidCallback onClicked}) {
    return IconButton(
      onPressed: onClicked,
      icon: const Icon(Icons.more_vert),
    );
  }

  Widget buildSheet() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      height: 300,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30))),
      child: Column(children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(31, 127, 127, 127),
                    shadowColor: Colors.transparent,
                    minimumSize: Size(100, 70)),
                onPressed: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.postuser == loginuser.value
                        ? ElevatedButton(
                            onPressed: widget.onDelete,
                            style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                                onPrimary: Colors.black87,
                                minimumSize: Size(100, 70)),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Color(0xFFB1ABAB),
                                ),
                                Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              widget.likeunlike!();
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                                onPrimary: Colors.black87,
                                minimumSize: Size(100, 70)),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color: widget.likeStatus!
                                      ? Colors.red
                                      : Color(0xFFB1ABAB),
                                ),
                                widget.likeStatus!
                                    ? Text(
                                        "unLike",
                                        style: TextStyle(color: Colors.black),
                                      )
                                    : Text(
                                        "Add to Favourite",
                                        style: TextStyle(color: Colors.black),
                                      )
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            widget.postuser == loginuser.value
                ? Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(31, 127, 127, 127),
                          shadowColor: Colors.transparent,
                          onPrimary: Colors.black87,
                          minimumSize: Size(100, 70)),
                      onPressed: () {
                        Navigator.pushNamed(context, PostEditScreen.id,
                            arguments: {
                              "postid": widget.postid,
                              "username": widget.username,
                              "userImage": widget.userimage,
                              "location": widget.location,
                              "description": widget.description,
                              "postimage": widget.images
                            });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.edit,
                            color: Color(0xFFB1ABAB),
                          ),
                          Text("Edit")
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shadowColor: Colors.transparent,
                          onPrimary: Colors.white,
                          minimumSize: Size(100, 70)),
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people,
                            color: Colors.white,
                          ),
                          Text("unfollow")
                        ],
                      ),
                    ),
                  )
          ],
        ),
        Column(
          children: [
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.pop(context);
                Navigator.pushNamed(context, NavigationDrawer.id, arguments: {
                  "pageIndex": 1,
                  "profilePicture": null,
                  "profileId": widget.postuser,
                  "isProfile": 1,
                });
              },
              child: Text(
                'view user profile',
                style: TextStyle(color: Colors.black45),
              ),
              style: ElevatedButton.styleFrom(
                  primary: secodaryColor,
                  shadowColor: Colors.transparent,
                  minimumSize: Size.fromHeight(40)),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'view Comments',
                style: TextStyle(color: Colors.black45),
              ),
              style: ElevatedButton.styleFrom(
                  primary: secodaryColor,
                  shadowColor: Colors.transparent,
                  minimumSize: Size.fromHeight(40)),
            ),
            ElevatedButton(
              onPressed: () {
                widget.supost!();
                Navigator.pop(context);
              },
              child: widget.savestatus!
                  ? Text(
                      'unSave Post',
                      style: TextStyle(color: Colors.black45),
                    )
                  : Text(
                      'Save Post',
                      style: TextStyle(color: Colors.black45),
                    ),
              style: ElevatedButton.styleFrom(
                  primary: secodaryColor,
                  shadowColor: Colors.transparent,
                  minimumSize: Size.fromHeight(40)),
            )
          ],
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildBottom(
        onClicked: () => showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) => buildSheet()));
  }
}
