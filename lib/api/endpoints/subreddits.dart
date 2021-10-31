import 'dart:convert';
import 'package:redditech/api/utils.dart';

class APISubreddits {

  APISubreddits();

  fetchPosts(key, after) async {
    var afterStr = after == null ? "" : "?after=$after";
    var response = await getAPI("$key.json$afterStr");
    return jsonDecode(response.body)["data"];
  }
}
