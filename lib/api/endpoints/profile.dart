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
    print(data);
    return data["subreddit"]["display_name"];
  }

  getProfilePicture() {
    return data["subreddit"]["icon_img"];
  }

  getBannerPicture() {
    String bannerURL = data["subreddit"]["banner_img"];
    print("url == $bannerURL");
    return bannerURL.replaceAll("amp;", "");
  }

  getBannerSize() {
    return data["subreddit"]["banner_size"];
  }

  getKarma() {
    return data["total_karma"];
  }

  getSubs() {
    return data["subreddit"]["subscribers"];
  }

  getDescription() {
    return data["subreddit"]["public_description"];
  }
}
