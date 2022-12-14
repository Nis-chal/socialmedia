import 'dart:io';

import 'package:socialmedia/response/shortsResponse/SavedShortsResponse.dart';
import 'package:socialmedia/response/shortsResponse/ShortsResponse.dart';
import 'package:socialmedia/api/shortsapi.dart';

class ShortsRepository {
  Future<ShortsResponse?> getShorts() async {
    return SHORTSAPI().getshorts();
  }

  Future<bool> likeShort(String shortid) async {
    return SHORTSAPI().likeShort(shortid: shortid);
  }

  Future<bool> unlikeShort(String shortid) async {
    return SHORTSAPI().unlikeShort(shortid: shortid);
  }

  Future<bool> dislikeShort(String shortid) async {
    return SHORTSAPI().dislikeShort(shortid: shortid);
  }

   Future<bool> undislikeShort(String shortid) async {
    return SHORTSAPI().undislikeShort(shortid: shortid);
  }

  Future<bool> saveShort(String shortid) async {
    return SHORTSAPI().saveShort(shortid: shortid);
  }

   Future<bool> unsaveShort(String shortid) async {
    return SHORTSAPI().unsaveShort(shortid: shortid);
  }

   Future<bool> deleteShort(String shortid) async {
    return SHORTSAPI().deleteShort(shortid: shortid);
  }


  Future<bool> addShort(File video, String description, String location) async {
    return SHORTSAPI().addShort(video:video,description:description,location:location);
  }

  Future<SavedShortsResponse?> savedShorts() async {
    return SHORTSAPI().savedShorts();
  }

}
