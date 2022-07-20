import 'package:flutter/material.dart';
import 'package:socialmedia/repository/PostRepository.dart';
import 'package:socialmedia/screens/ImageSlider.dart';
import 'package:socialmedia/screens/post/post_detail.dart';
import 'package:socialmedia/utils/url.dart';

class PostEditScreen extends StatefulWidget {
  static const String id = 'edit_screen';

  PostEditScreen({Key? key}) : super(key: key);

  @override
  State<PostEditScreen> createState() => _PostEditScreenState();
}

class _PostEditScreenState extends State<PostEditScreen> {
  final _location = TextEditingController();
  final _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      // appBar: AppBar(

      //   title: Text('Edit Info'),
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      //   shadowColor: Colors.transparent,
      //   leading: ElevatedButton(child: Text('cancel'), onPressed: (){},
      //   style: ElevatedButton.styleFrom(

      //     minimumSize: Size(30, 10)
      //   ),)

      //   ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('cancel'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    onPrimary: Colors.black,
                    shadowColor: Colors.transparent,
                  ),
                ),
                Text(
                  "Edit Info",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                ElevatedButton(
                  onPressed: () async {
                    bool post = await PostRepository().updatePost(
                        _location.text,
                        _description.text,
                        args['postid'],
                        args['postimage']);

                    if (post) {
                      Navigator.pushNamed(context, PostDetailScreen.id,
                          arguments: args['postid']!);
                    }
                  },
                  child: Text('Done'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    onPrimary: Colors.blue[600],
                    shadowColor: Colors.transparent,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        NetworkImage('$baseUr${args['userImage']}'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _description
                        ..text = args['description'] ?? '',
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: 'Add description',
                          labelText: 'Description',
                          labelStyle: TextStyle(color: Colors.black45),
                          hintStyle: TextStyle(color: Colors.black45),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent))),
                      autofocus: true,
                    ),
                  ),
                  Stack(children: [
                    Image.network(
                      '$baseUr${args['postimage'][0]}',
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                        top: -9,
                        right: -10,
                        child: IconButton(
                          icon: args['postimage'].length > 1
                              ? const Icon(
                                  Icons.content_copy,
                                  color: Colors.white,
                                )
                              : const Icon(Icons.file_copy),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                contentPadding: EdgeInsets.all(10),
                                content: Container(
                                    width: 900,
                                    height: 490,
                                    child: ImageSlider(
                                      listofImage: args['postimage'],
                                    )),
                              ),
                            );
                          },
                        ))
                  ])
                ],
              ),
            ),
            Container(
              height: 2,
              color: Colors.black45,
            ),
            SizedBox(
              height: 10,
            ),

            TextField(
              controller: _location..text = args['location'] ?? '',
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: 'Add location',
                  labelText: 'Location',
                  labelStyle: TextStyle(color: Colors.black45),
                  hintStyle: TextStyle(color: Colors.black45),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent))),
              autofocus: true,
            ),
            Container(
              height: 2,
              color: Colors.black45,
            ),
            // ImageSlider(listofImage: args['postimage']!),
          ],
        ),
      ),
    );
  }
}
