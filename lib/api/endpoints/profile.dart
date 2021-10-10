import 'dart:convert';

import 'package:redditech/api/utils.dart';

class APIProfile {
  var data;

  APIProfile();

  fetch() async {
    var response = await fetchAPI("me");
    data = jsonDecode(response.body);
  }

  getDisplayName() {
    return data["subreddit"]["display_name"];
  }
}
