import 'package:flutter/material.dart';
import 'package:socialmedia/components/comment.dart/singleComment.dart';
import 'package:socialmedia/models/CommentsModel.dart';
import 'package:socialmedia/repository/CommentRepository.dart';
import 'package:socialmedia/response/commentResponse/CommentResponse.dart';

class PostCommentScreen extends StatefulWidget {
  static const String id = "post_comment";
  String arguments;

  PostCommentScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  State<PostCommentScreen> createState() => _PostCommentScreenState();
}

class _PostCommentScreenState extends State<PostCommentScreen> {
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
      body: FutureBuilder<CommentResponse?>(
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
    );
  }
}
