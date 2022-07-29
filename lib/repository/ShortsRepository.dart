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
}
