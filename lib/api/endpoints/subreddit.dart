import 'dart:convert';
import 'package:redditech/api/utils.dart';

class APISubreddit {

  var data = {};
  String subredditName;

  APISubreddit(this.subredditName);

  fetch() async {
    var about = await getAPI(this.subredditName + "/about");
    var responseBest = await getAPI(this.subredditName + "/best");
    var responseHot = await getAPI(this.subredditName + "/hot");
    var responseTop = await getAPI(this.subredditName + "/top");
    try {
      data["about"] = jsonDecode(about.body)["data"];
      data["best"] = jsonDecode(responseBest.body)["data"];
      data["hot"] = jsonDecode(responseHot.body)["data"];
      data["top"] = jsonDecode(responseTop.body)["data"];
    } catch (_) {
      data = {};
      return false;
    }
    return true;
  }

  getAbout() {
    return data["about"];
  }

  getBestPosts() {
    return data["best"]["children"];
  }

  getHotPosts() {
    return data["hot"]["children"];
  }

  getTopPosts() {
    return data["top"]["children"];
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
