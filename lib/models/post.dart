import 'package:flutter/material.dart';

class Post {
  String? username, address, date,  description,userimage;

  List<String>? image;

  Post({
    
    this.username,
    this.address,
    this.date,
    this.image,
    this.description,
    this.userimage,
  });
}
