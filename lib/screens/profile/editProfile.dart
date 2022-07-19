import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:socialmedia/repository/ProfileRepository.dart';
import 'package:socialmedia/responsive/navigation_drawer.dart';
import 'package:socialmedia/utils/url.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  static const String id = 'edit_profile';

  Map arguments;

  EditProfileScreen(this.arguments, {Key? key}) : super(key: key);

  _updateProfile() async {
    ProfileRepository profileRepository = ProfileRepository();

    bool? update = await profileRepository.updateUser();
  }

  File? fimage;
  RxBool loaded = false.obs;

  Future _loadImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        fimage = File(image.path);
        loaded.value = true;
      } else {
        return;
      }
    } catch (e) {
      debugPrint('Failed to pick Image $e');
    }
  }

  Widget changeImage({required VoidCallback onpop}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 150,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        textDirection: TextDirection.rtl,
        children: [
          GestureDetector(
            onTap: () {
              _loadImage(ImageSource.camera);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              height: 40,
              child: Center(child: Text('Take a Photo')),
            ),
          ),
          GestureDetector(
            onTap: () {
              _loadImage(ImageSource.gallery);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              height: 40,
              child: Center(child: Text('Choose From Gallery')),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: onpop,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(9))),
              height: 40,
              child: const Center(child: Text('cancel')),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _name = TextEditingController()..text = arguments['name'];
    final _username = TextEditingController()..text = arguments['username'];
    final _location = TextEditingController()..text = arguments['location'];
    final _email = TextEditingController()..text = arguments['email'];
    String? nimage = arguments['profilePicture'];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'cancel',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.normal),
                      )),
                  const Text(
                    'Edit Profile',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: () async {
                        ProfileRepository profileRepository =
                            ProfileRepository();

                        bool? update = await profileRepository.updateUser(
                            name: _name.text,
                            username: _username.text,
                            email: _email.text,
                            fimage: fimage,
                            nimage: nimage,
                            userid: arguments["id"],
                            location: _location.text);

                        if (update!) {
                          Navigator.pushNamed(context, NavigationDrawer.id,
                              arguments: 3);
                        } else {
                          MotionToast.warning(description: Text('error Invalid credential'))
                              .show(context);
                        }
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Obx(
                    () => loaded.value
                        ? Image.file(
                            File(fimage!.path),
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            '$baseUr${arguments['profilePicture']}',
                            fit: BoxFit.cover,
                          ),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) => changeImage(
                            onpop: () {
                              Navigator.pop(context);
                            },
                          ));
                },
                child: Text(
                  'change profile photo',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              height: 600,
              child: GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 5,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 100, child: Text('username')),
                      Expanded(
                        child: TextField(
                          controller: _username,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 100, child: Text('username')),
                      Expanded(
                        child: TextField(
                          controller: _name,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 100, child: Text('email')),
                      Expanded(
                        child: TextField(
                          controller: _email,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 100, child: Text('location')),
                      Expanded(
                        child: TextField(
                          controller: _location,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
