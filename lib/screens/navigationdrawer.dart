import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/components/addPostCarousel.dart';
import 'package:socialmedia/models/User.dart';

import 'package:socialmedia/screens/feedScreen.dart';
import 'package:socialmedia/screens/loginScreen.dart';
import 'package:socialmedia/screens/add_post.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/screens/post/postProviewScreen.dart';
import 'package:socialmedia/screens/profile/profileScreen.dart';

// import 'package:socialmedia/responsive/feed_layout.dart';
import 'ImageSlider.dart';

class NavigationDrawer extends StatefulWidget {
  static const String id = 'NavigagtionDrawer_screen';

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {


  RxInt _selectedIndex = 0.obs;


  final ImagePicker _picker = ImagePicker();
  
  final  List<File> _imageList = [];
  File? img;

  RxString userid = ''.obs;


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


      

      
    });
  }
 
 
  void imageSelect() async{
    final selectedImage = await _picker.pickMultiImage();
    if(selectedImage!.isNotEmpty){
      
    setState(() {

      for(var image in selectedImage){

      img =File(image.path) ;
      
      _imageList.add(File(image.path));
      }
    });

    Navigator.pushNamed(context, PostPreviewScreen.id,arguments: _imageList);
    }
  }
  

  
 

  @override
  Widget build(BuildContext context) {
  List<Widget> lstWidget = [
    FeedScreen(),
    ProfileScreen(userid.value)
   
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
             

            if(index == 3 ){
              imageSelect();
                


            }
            // if(index ==1){
            //       Navigator.pushNamed(context, ProfileScreen.id,arguments: userid.value);


            // }

            if(index == 2 ){
                  Navigator.pushNamed(context, PostPreviewScreen.id);

                


            }
            _selectedIndex.value = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo_sharp),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user),
            label: 'profile',
          ),
        ],
      ),
      body: lstWidget[_selectedIndex.value],
    );
  }
  
  
}
