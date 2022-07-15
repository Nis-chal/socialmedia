import 'package:flutter/material.dart';
import 'package:socialmedia/components/post_card.dart';
import 'package:socialmedia/models/Posts.dart';
import 'package:socialmedia/repository/PostRepository.dart';
class PostDetailScreen extends StatefulWidget {
    static const String id = 'postedit_screen';

  final String? args;
  const PostDetailScreen(this.args,{Key? key}) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
 @override
  void initState() {
    _postdetial();
    
    super.initState();
  }
  String?  username, description, address, userimage,updatedAt,id;
  List<String>? image,likesid,commentsid,saved;
  DateTime? createdAt,date;


  _postdetial()async{
    PostRepository postRepository = PostRepository();
    Posts? post = await postRepository.postDetail(widget.args!);
    setState(() {
      username=post?.userid?.username;
      userimage = post?.userid?.profilePicture;
      description =post?.description;
      address = post?.location;
      updatedAt = post?.updatedAt;
      image = post?.images;
      commentsid =post?.commentsid;
      saved = post?.saved;
      createdAt = post?.createdAt;
      date = post?.createdAt;

    });

  }

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(child:
      PostCard(
        address:address ,
      username: username,
      userimage: userimage,
      description: description,
      updatedAt: updatedAt,
      image: image,
      commentsid: commentsid,
      saved: saved,
      createdAt: createdAt,
      date: date,

      )
       ),
    );
  }
}