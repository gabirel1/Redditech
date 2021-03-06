import 'dart:convert';
import 'package:redditech/api/utils.dart';

class APISubreddit {

  var data = {};
  String subredditName;

  APISubreddit(this.subredditName);

  fetch() async {
    var about = await getAPI(this.subredditName + "/about");
    try {
      data["about"] = jsonDecode(about.body)["data"];
    } catch (_) {
      data = {};
      return false;
    }
    return true;
  }

  getAbout() {
    return data["about"];
  }

  fetchPosts(key, after) async {
    var afterStr = after == null ? "" : "?after=$after";
    var response = await getAPI(this.subredditName + "/$key$afterStr");
    return jsonDecode(response.body)["data"];
  }

  isSubscribed() {
    return data["about"]["user_is_subscriber"];
  }

  subscribe() {
    return postAPI("api/subscribe", {"sr": data["about"]["name"], "action": "sub"});
  }

  unSubscribe() async {
    return postAPI("api/subscribe", {"sr": data["about"]["name"], "action": "unsub"});
  }
}
