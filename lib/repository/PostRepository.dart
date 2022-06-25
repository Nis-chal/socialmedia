import 'dart:io';
import 'package:dio/dio.dart';

import '../api/postapi.dart';
import '../response/FeedsResponse.dart';

class PostRepository{
  Future<FeedsResponse?> getFeeds() async {
    return PostAPI().feeds();
  }




  

  
}