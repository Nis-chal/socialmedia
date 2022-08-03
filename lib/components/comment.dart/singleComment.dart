import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/models/User.dart';
import 'package:socialmedia/repository/CommentRepository.dart';
import 'package:socialmedia/utils/url.dart';
import 'package:timeago/timeago.dart ' as timeago;

class SingleComment extends StatefulWidget {
  String? profilePicture, commentid, content, postid, commentedBy, username;
  DateTime? createdAt;

  SingleComment(
      {this.profilePicture,
      this.commentid,
      this.content,
      this.postid,
      this.createdAt,
      this.commentedBy,
      this.username,
      Key? key})
      : super(key: key);

  @override
  State<SingleComment> createState() => _SingleCommentState();
}

class _SingleCommentState extends State<SingleComment> {
  RxBool isupdate = false.obs;

  RxString userid = ''.obs;
  RxBool option = false.obs;
  RxBool isDelete = false.obs;
  RxString description = ''.obs;
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  @override
  void dispose() {
    super.dispose();
    _loadCounter();
  }

  _updateComment() async {
    CommentRepository commentRepository = CommentRepository();
    bool isupdated = await commentRepository.updateComments(
        widget.commentid!, _editController.text);
  }

  final _editController = TextEditingController();
  _deleteComment() async {
    CommentRepository commentRepository = CommentRepository();
    bool isupdated = await commentRepository.deleteComments(widget.commentid!);
    if (isupdated) {
      isDelete.value = true;
      
    }
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      var data = (prefs.getString('userdata') ?? '');
      var userdatas = User.fromJson(jsonDecode(data.toString()));
      userid.value = userdatas.id.toString();
      // _editController.text = widget.content!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Visibility(
          visible: isDelete.value ? false : true,
          child: Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: Stack(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(baseUr + widget.profilePicture!),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Stack(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            widget.username!,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Obx(
                            () => TextField(
                                autofocus: false,
                                controller: _editController
                                  ..text = widget.content!,
                                style: const TextStyle(
                                    color: Colors.black45, fontSize: 14),
                                enabled: isupdate.value,
                                decoration: !isupdate.value
                                    ? const InputDecoration(
                                        isDense: true,
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(0),
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      )
                                    : const InputDecoration(
                                        isDense: true,
                                        fillColor: Colors.black54,
                                        contentPadding: EdgeInsets.all(5))),
                          ),
                          Text(
                            timeago.format(widget.createdAt!),
                            style:
                                TextStyle(fontSize: 10, color: Colors.black38),
                          )
                        ],
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Obx(
                          () => Visibility(
                            visible: isupdate.value ? true : false,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _updateComment();
                                    isupdate.value = false;
                                  },
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _editController.text = widget.content!;
                                    isupdate.value = false;
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.redAccent,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                  Visibility(
                    visible: widget.commentedBy == userid.value ? true : false,
                    child: IconButton(
                      onPressed: () {
                        option.value = !option.value;
                      },
                      icon: Icon(Icons.more_horiz_sharp),
                    ),
                  )
                ],
              ),
              Positioned(
                  top: 32,
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
                            GestureDetector(
                              onTap: () {
                                isupdate.value = true;
                                option.value = !option.value;
                              },
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _deleteComment();
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
            ]),
          ),
        ));
  }
}
