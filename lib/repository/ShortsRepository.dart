import 'package:socialmedia/response/shortsResponse/ShortsResponse.dart';
import 'package:socialmedia/api/shortsapi.dart';

class ShortsRepository {
  Future<ShortsResponse?> getShorts() async {
    return SHORTSAPI().getshorts();
  }

  Future<bool> likeShort(String shortid) async {
    return SHORTSAPI().likeShort(shortid:shortid);
  }
}
