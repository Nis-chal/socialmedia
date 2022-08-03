import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/components/addPostCarousel.dart';
import 'package:socialmedia/models/User.dart';

import 'package:socialmedia/screens/feedScreen.dart';
import 'package:socialmedia/screens/add_post.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/screens/post/postProviewScreen.dart';
import 'package:socialmedia/screens/profile/profileScreen.dart';
import 'package:socialmedia/utils/url.dart';
import 'package:socialmedia/screens/post/explorePost.dart';

// import 'package:socialmedia/responsive/feed_layout.dart';

class NavigationDrawer extends StatefulWidget {
  static const String id = 'NavigagtionDrawer_screen';

  int? activeTab = 0;

  Map? idImage;

  NavigationDrawer({this.idImage});

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  final RxInt _selectedIndex = 0.obs;

  final ImagePicker _picker = ImagePicker();

  final List<File> _imageList = [];
  File? img;

  RxString userid = ''.obs;
  RxString userpic = ''.obs;

  String? profilePicture;
  RxBool ispic = false.obs;
  RxBool issearch = false.obs;

  RxInt profileview = 0.obs;
  RxString profileid = "".obs;

  @override
  void initState() {
    _loadCounter();
    super.initState();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      var data = (prefs.getString('userdata') ?? '');
      var userdatas = User.fromJson(jsonDecode(data.toString()));
      userid.value = userdatas.id.toString();
      userpic.value = userdatas.profilePicture!;
      profileview.value = widget.idImage!['isProfile'] ?? 0;
      profileid.value = widget.idImage!['profileId'] ?? '';
      if (widget.idImage!['pageIndex'] != null) {
        _selectedIndex.value = widget.idImage!['pageIndex']!;

        if (widget.idImage!['profilePicture'] != null) {
          // userpic.value = widget.idImage!['profilePicture'];
          ispic.value = true;
        } else {
          ispic.value = false;
        }
      }
    });
  }

  void imageSelect() async {
    final selectedImage = await _picker.pickMultiImage();
    if (selectedImage!.isNotEmpty) {
      setState(() {
        for (var image in selectedImage) {
          img = File(image.path);

          _imageList.add(File(image.path));
        }
      });

      Navigator.pushNamed(context, PostPreviewScreen.id, arguments: _imageList);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> lstWidget = [
      FeedScreen(),
      Obx(
        () => issearch.value
            ? ExplorePost(profileid.value, profileview.value)
            : ExplorePost(profileid.value, profileview.value),
      ),
      FeedScreen(),
      ProfileScreen(arguments: userid.value),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 228, 228, 228),
        currentIndex: _selectedIndex.value,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color.fromARGB(255, 95, 95, 95),
        elevation: 10,
        onTap: (index) {
          setState(() {
            if (index == 2) {
              imageSelect();
            } else {
              issearch.value = false;
              _selectedIndex.value = index;
            }
            // if(index == 3){
            //       Navigator.pushNamed(context, ProfileScreen.id,arguments: userid.value);

            // }

            // if(index == 3 ){
            //       Navigator.pushNamed(context, PostPreviewScreen.id);

            // }
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo_sharp),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Obx(() => CircleAvatar(
                    backgroundImage: NetworkImage(
                  baseUr + userpic.value,
                ))),
            label: 'profile',
          ),
        ],
      ),
      body: lstWidget[_selectedIndex.value],
    );
  }
}
