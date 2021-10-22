import 'dart:convert';
import 'package:redditech/api/utils.dart';

class APISubreddits {
  var data = {};
  var comments;

  APISubreddits();

  fetch() async {
    var responseBest = await getAPI("best.json");
    var responseHot = await getAPI("hot.json");
    var responseTop = await getAPI("top.json");
    try {
      data["best"] = jsonDecode(responseBest.body)["data"];
      data["hot"] = jsonDecode(responseHot.body)["data"];
      data["top"] = jsonDecode(responseTop.body)["data"];
    } catch (_) {
      data = {};
      return false;
    }
    return true;
  }

  getBestSubs() {
    return data["best"]["children"];
  }

  getHotSubs() {
    return data["hot"]["children"];
  }

  getTopSubs() {
    return data["top"]["children"];
  }
}
