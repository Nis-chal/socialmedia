import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socialmedia/repository/PostRepository.dart';
import 'package:socialmedia/screens/post/post_detail.dart';
class AddPostDecriptionScreen extends StatelessWidget {
   AddPostDecriptionScreen({Key? key}) : super(key: key);
  
  final _location = TextEditingController() ;
  final _description = TextEditingController() ;
  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as List<File>;

    return Scaffold(

      //   ),

        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('cancel'),
                style: ElevatedButton.styleFrom(

                  primary: Colors.transparent,
                  onPrimary: Colors.black,
                  shadowColor: Colors.transparent,
                ),
                ),
                Text("Edit Info",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                ElevatedButton(onPressed: ()async{

                  bool post =  await PostRepository().addFeed(args, _description.text);

                  if(post){
                    // Navigator.pushNamed(context, PostDetailScreen.id,arguments: args['postid']!);
                    
                  }

                }, child: Text('Done'),
                style: ElevatedButton.styleFrom(

                  primary: Colors.transparent,
                  onPrimary: Colors.blue[600],
                  shadowColor: Colors.transparent,
                ),
                )
        
              ],),
              SizedBox(height: 10,)
              ,
        
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  
                  children: [
                    
        
                    
                    SizedBox(width: 10,),
                    
                    
                        Expanded(
                          child: TextField(
                            controller: _description,
                            keyboardType: TextInputType.emailAddress,
                            decoration:const InputDecoration(hintText: 'Add description',
                            labelText: 'Description',
                            labelStyle: TextStyle(color: Colors.black45),
                            hintStyle: TextStyle(color: Colors.black45), focusedBorder:OutlineInputBorder(borderSide:BorderSide(color: Colors.transparent) ),
                            enabledBorder:OutlineInputBorder(borderSide:BorderSide(color: Colors.transparent) )
                             ),
                            autofocus: true,
                          
                          ),
                        ),
                        Stack(
                          children: [Image.file(File(args[0].path),height: 70,width: 70,
                          fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: -9,
                            right: -10,
                            child: IconButton(icon:
                            args.length> 1?
                            const Icon(
                              
                              Icons.content_copy,
                              
                              color: Colors.white,):const Icon(Icons.file_copy) ,
                              onPressed: (){

                                showDialog(context: context, 
                                builder: (context)=>AlertDialog(
                                  contentPadding: EdgeInsets.all(10),
                                  content: Container(
                                  width: 900,
                                  height: 490,
                                  child: 
                                ImageSlider(listofImage: args,)
                                ),),
                                
                                );
                              },
                              )
                              
                              
                              )
                          ]
                        )
                  ],
                ),
              ),
              Container(height: 2,
              color: Colors.black45,
              ),
              SizedBox(
                height: 10,
              ),

              TextField(
                            controller: _location,
                            keyboardType: TextInputType.emailAddress,
                            decoration:const InputDecoration(hintText: 'Add location',
                            labelText: 'Location',
                            labelStyle: TextStyle(color: Colors.black45),
                            hintStyle: TextStyle(color: Colors.black45), focusedBorder:OutlineInputBorder(borderSide:BorderSide(color: Colors.transparent) ),
                            enabledBorder:OutlineInputBorder(borderSide:BorderSide(color: Colors.transparent) )
                             ),
                            autofocus: true,
                          
                          ),
                           Container(height: 2,
              color: Colors.black45,
              ),
              // ImageSlider(listofImage: args['postimage']!),
            ],
          ),
        ),
       
    );
  }
}