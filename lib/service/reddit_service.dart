import 'package:dio/dio.dart';

class RedditService {
  getContent(String subreddit) async {
    try {
      var response =
          await Dio().get('https://www.reddit.com/r/${subreddit}/top.json?');
      print(response.statusCode);
      return response.data;
      // print(response);
    } catch (e) {
      print(e);
      return null;
    }
  }

  getComments(String subreddit, String id) async {
    try {
      var response = await Dio()
          .get('https://www.reddit.com/r/${subreddit}/comments/${id}.json?');
      print(response.statusCode);
      return response.data;
      // print(response);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
