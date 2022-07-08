import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/repository/PostRepository.dart';
import 'package:socialmedia/models/Posts.dart';

import 'package:motion_toast/motion_toast.dart';
class AddPost extends StatefulWidget {
  AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final ImagePicker _picker = ImagePicker();
  final  List<File> _imageList = [];
  File? img;
  void imageSelect() async{
    final selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    if(selectedImage!.path.isNotEmpty){
      
    setState(() {
      img =File(selectedImage.path) ;
      
      _imageList.add(File(selectedImage.path));
    });
    }
  }


  _addProduct(List<File> images, String location) async {
    bool isAdded = await PostRepository().addFeed(_imageList, location);
   
  }

    _displayMessage(bool isAdded) {
    if (isAdded) {
      MotionToast.success(description: const Text("Post added successfully"))
          .show(context);
    } else {
      MotionToast.error(description: const Text("Error adding post"))
          .show(context);
    }
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Column(
      children: [
        OutlinedButton(
          onPressed: (){
            imageSelect();
          },
          child: Text('Selected Image'),
        ),
          Expanded(
            child: GridView.builder(
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:3),
                itemCount: _imageList.length,
                itemBuilder:(BuildContext context,int index){
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.file(
                          File(_imageList[index].path ),
                          fit:BoxFit.cover,
                        ),
                        Positioned(
                          right: 4,
                          top: 4,
                          child: Container(
                            color: Colors.amber,
                            child:IconButton(
                              onPressed: (){
                                _imageList.removeAt(index);
                                setState(() {
                                  
                                });
                              }, 
                              icon:Icon(Icons.delete),
                              color: Colors.blue,
                              ),
                              ),
                        )
                      ],
                    ),
                  );
          
                }),
          ),

          ElevatedButton(onPressed: (){
            _addProduct(_imageList, "new");
          }, child: Text('submit'))
      ],
    ),
    ),
    );
  }
}