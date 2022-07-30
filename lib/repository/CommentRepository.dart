

import 'package:socialmedia/api/commentapi.dart';
import 'package:socialmedia/response/commentResponse/CommentResponse.dart';

class CommentRepository{

  Future<CommentResponse?> getComments(String commentid) async {
    return CommentAPI().getComments(commentid: commentid);
  }
}