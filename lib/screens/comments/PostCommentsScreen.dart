import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/components/comment.dart/singleComment.dart';
import 'package:socialmedia/models/CommentsModel.dart';
import 'package:socialmedia/models/User.dart';
import 'package:socialmedia/repository/CommentRepository.dart';
import 'package:socialmedia/repository/ShortsRepository.dart';
import 'package:socialmedia/response/commentResponse/CommentResponse.dart';
import 'package:socialmedia/utils/url.dart';

class PostCommentScreen extends StatefulWidget {
  static const String id = "post_comment";
  String arguments;

  PostCommentScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  State<PostCommentScreen> createState() => _PostCommentScreenState();
}

class _PostCommentScreenState extends State<PostCommentScreen> {
  RxString profilePicture = ''.obs;
  RxString username = ''.obs;
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
      profilePicture.value = userdatas.profilePicture!;
      username.value = userdatas.username!;
    });
  }

  _addComment() async {
    CommentRepository commentRepository = CommentRepository();
    bool added = await commentRepository.addComments(
        _commentController.text, widget.arguments);
    if (added) {
      setState(() {
        _commentController.text = "";
      });
    }
  }

  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          'comments',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: FutureBuilder<CommentResponse?>(
            future: CommentRepository().getComments(widget.arguments),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data != null) {
                  // ProductResponse productResponse = snapshot.data!;
                  List<CommentsModel> commentlst = snapshot.data!.comment!;

                  return ListView.separated(
                      itemCount: commentlst.length,
                      separatorBuilder: (context, index) => const Divider(),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return (SingleComment(
                          profilePicture:
                              commentlst[index].commentedBy!.profilePicture,
                          commentid: commentlst[index].id,
                          content: commentlst[index].content,
                          postid: commentlst[index].postid,
                          createdAt: commentlst[index].createdAt,
                          commentedBy: commentlst[index].commentedBy!.id,
                          username: commentlst[index].commentedBy!.username,
                        ));
                      });
                } else {
                  return const Center(
                    child: Text("No data"),
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
            },
          ),
        ),
        Positioned(
            bottom: 0,
            child: Container(
              // width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                      style: BorderStyle.solid)),
              child: Row(children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(baseUr + profilePicture.value),
                ),
                // Text('jjj')
              ]),
            ))
      ]),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 70,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(baseUr + profilePicture.value),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Comment as ${username}',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _addComment();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: const Text(
                    'Post',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
