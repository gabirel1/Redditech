import 'dart:convert';
import 'package:redditech/api/utils.dart';

class APISubreddits {
  var data;
  var comments;

  APISubreddits();

  fetch() async {
    var response = await getAPI("subreddits/popular");
    try {
      data = jsonDecode(response.body)["data"];
    } catch (_) {
      data = [];
      return false;
    }
    return true;
  }

  getPopularSubs() {
    return data["children"];
  }
}
