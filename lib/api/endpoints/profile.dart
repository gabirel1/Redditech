import 'dart:convert';

import 'package:redditech/api/utils.dart';

class APIProfile {
  var data;

  APIProfile();

  fetch() async {
    var response = await getAPI("me");
    data = jsonDecode(response.body);
  }

  getDisplayName() {
    return data["subreddit"]["display_name"];
  }

  getPicture() {
    return data["subreddit"]["icon_img"];
  }
}
