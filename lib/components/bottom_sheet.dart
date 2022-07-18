import 'package:flutter/material.dart';
import 'package:socialmedia/constants.dart';
import 'package:socialmedia/screens/post/post_edit.dart';

class BottomTab extends StatefulWidget {
  String? postid, username, location, description, userimage;
  VoidCallback? onDelete;
  List<String>? images;
  BottomTab(
      {Key? key,
      this.postid,
      this.onDelete,
      this.images,
      this.username,
      this.location,
      this.description,
      this.userimage})
      : super(key: key);

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
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
                    ElevatedButton(
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
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(31, 127, 127, 127),
                    shadowColor: Colors.transparent,
                    onPrimary: Colors.black87,
                    minimumSize: Size(100, 70)),
                onPressed: () {
                  Navigator.pushNamed(context, PostEditScreen.id, arguments: {
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
          ],
        ),
        Column(
          children: [
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
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
              onPressed: () {},
              child: Text(
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
