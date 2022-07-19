import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmedia/utils/url.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  static const String id = 'edit_profile';

  Map arguments;

  EditProfileScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _name = TextEditingController()..text = arguments['name'];
    final _username = TextEditingController()..text = arguments['username'];
    final _location = TextEditingController()..text = arguments['location'];
    final _email = TextEditingController()..text = arguments['email'];

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
                child: Image.network(
                  '$baseUr${arguments['profilePicture']}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {},
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
