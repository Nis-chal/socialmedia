import 'package:flutter/material.dart';
import 'package:socialmedia/components/post_card.dart';
import 'package:socialmedia/models/Posts.dart';
import 'package:socialmedia/repository/PostRepository.dart';
import 'package:socialmedia/response/PostDetailResponse.dart';
class PostDetailScreen extends StatefulWidget {
    static const String id = 'postedit_screen';

  final String? args;
  const PostDetailScreen(this.args,{Key? key}) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {

  String?  username, description, address, userimage,updatedAt,id;
  List<String>? image,likesid,commentsid,saved;
  DateTime? createdAt,date;




  

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Post Detail'),

        leading: IconButton(onPressed: (() {
          
        }),
        icon: Icon(Icons.back_hand),
      ),),
      body: SafeArea(child:

      FutureBuilder<PostDetailResponse?>(
        future: PostRepository().postDetail(widget.args!),
        builder:(context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.data !=null){

              Posts? feed = snapshot.data!.post ;
              return SizedBox(
                height: 720,
                child: (
              
                  
              
                    PostCard(
                      address:feed!.location ,
                    username: feed.userid!.username??"hello",
                    userimage: feed.userid!.profilePicture??"sdf",
                    description: feed.description,
                    updatedAt: feed.updatedAt,
                    image: feed.images,
                    commentsid:feed.commentsid,
                    saved: feed.saved,
                    createdAt:feed. createdAt,
                    date: feed.createdAt,
                    likesid: feed.likesid,
              
                    )
              
                    //             PostCard(
                    //   address:address ,
                    // username: username,
                    // userimage: userimage,
                    // description: description,
                    // updatedAt: updatedAt,
                    // image: image,
                    // commentsid: commentsid,
                    // saved: saved,
                    // createdAt: createdAt,
                    // date: date,
              
                    // )
                ),
              );
              
            }else{
              return const Center(
                  child: Text("No data"),
                );

            }
          }
          else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }else {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              );
            }


      } ,)
   
       ),
    );
  }
}