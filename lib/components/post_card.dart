import 'package:flutter/material.dart';
import './like_animation.dart';
import '../utils/url.dart';
import 'package:socialmedia/screens/ImageSlider.dart';
import 'package:socialmedia/components/bottom_sheet.dart';

import 'package:timeago/timeago.dart ' as timeago;
import 'package:get/get.dart';
class PostCard extends StatefulWidget {
  @override
  State<PostCard> createState() => _PostCardState();
  String?  username, description, address, userimage,updatedAt,id;
  List<String>? image,likesid,commentsid,saved;
  DateTime? createdAt,date;

  PostCard(
      {
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
      this.createdAt
      
      });
}

class _PostCardState extends State<PostCard> {
  int commentLen = 0;
  var isLikeAnimating = false.obs;
  var liked = false.obs;
  



  


  
  late var likelength = widget.likesid!.length.obs;

  void increament(){
   
    likelength++;
    liked.value = true;




    
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: Colors.black,
        // ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
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
                  radius: 10,
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
                      ],
                    ),
                  ),
                ),
                BottomTab()
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () {

              
                isLikeAnimating.value = true ;

              
              
              
              
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
ImageSlider(listofImage: widget.image),

               Obx(()=>

                AnimatedOpacity(
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

                        if (liked.isTrue){

                        likelength--;
                        liked.value = false;
                        }else{

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
                child: 
                Obx((() => 
                
                IconButton(
                  
                  icon: liked.value
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border,
                        ),
                  onPressed: () {},
                )
                ),
                )


                
              ),
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
                child: IconButton(
                    icon: const Icon(Icons.bookmark_border), onPressed: () {}),
              ))
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
                    child: 
                    Obx(() => 
                    
                    Text(
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
                    timeago.format(widget.createdAt!) ,
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
    );
  }
}
