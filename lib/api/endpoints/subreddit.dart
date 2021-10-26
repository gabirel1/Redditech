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
}
