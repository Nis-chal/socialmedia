import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/models/User.dart';
import 'package:socialmedia/utils/url.dart';
import 'package:timeago/timeago.dart ' as timeago;

class SingleComment extends StatefulWidget {
  String? profilePicture, commentid, content, postid;
  DateTime? createdAt;

  SingleComment(
      {this.profilePicture,
      this.commentid,
      this.content,
      this.postid,
      this.createdAt,
      Key? key})
      : super(key: key);

  @override
  State<SingleComment> createState() => _SingleCommentState();
}

class _SingleCommentState extends State<SingleComment> {
  final _nameController = TextEditingController();
  RxBool isupdate = false.obs;

  RxString userid = ''.obs;
  RxBool option = false.obs;

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
      userid.value = userdatas.id.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(baseUr + widget.profilePicture!),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => TextField(
                    enabled: isupdate.value,
                    controller: _nameController..text = widget.content!,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(0)),
                  ),
                ),
                Text(timeago.format(widget.createdAt!))
              ],
            ),
          ),
          Stack(children: [
            IconButton(
              onPressed: () {
                option.value = !option.value;
              },
              icon: Icon(Icons.more_horiz_sharp),
            ),
          ])
        ],
      ),
      Positioned(
          top: 37,
          right: 5,
          child: Obx(
            () => Visibility(
              visible: option.value ? true : false,
              child: Container(
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ))
    ]);
  }
}
