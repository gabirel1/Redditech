import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:redditech/api/utils.dart';

class APIProfile {
  var data;
  var comments;

  APIProfile();

  fetch() async {
    var response = await getAPI("me", v1: true);
    print(response);
    try {
      data = jsonDecode(response.body);
      var response2 = await getAPI("user/" + data["name"] + "/comments");
      comments = jsonDecode(response2.body);
    } catch (_) {
      data = [];
      return false;
    }
    return true;
  }

  getDisplayName() {
    return data["subreddit"]["display_name"];
  }

  getProfilePicture() {
    // return (data["subreddit"]["icon_img"])
    //     ? data["subreddit"]["icon_img"]
    //     : data["snoovatar_img"];
    // if (data["subreddit"]["icon_img"] == "") {
    //   print("connard");
    //   return data["snoovatar_img"];
    // }
    if (data["snoovatar_img"] == "") {
      return (data["subreddit"]["icon_img"]);
    } else {
      return data["snoovatar_img"];
    }
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

  getTimeSinceCreation() {
    double createdAt = data["created_utc"];

    var today = DateTime.now();
    int createdAtMilliseconds = createdAt.toInt() * 1000;
    var createdAtDate =
        DateTime.fromMillisecondsSinceEpoch(createdAtMilliseconds);
    int timeInDay = today.difference(createdAtDate).inDays;
    print(timeInDay);
    return timeInDay.toString();
  }

  getDateOfCreation() {
    double createdAt = data["created_utc"];
    int createdAtMilliseconds = createdAt.toInt() * 1000;
    var createdAtDate =
        DateTime.fromMillisecondsSinceEpoch(createdAtMilliseconds);
    var formatted = DateFormat("dd MMMM yyyy").format(createdAtDate);
    return formatted.toString();
  }

  getCommentKarma() {
    return data["comment_karma"];
  }

  getComments() {
    List arr = [];
    // print(comments["data"]["dist"]);
    // for (int i = 0; i < comments["data"]["dist"]; i++) {
    //   arr.add(comments["data"]["children"][i]);
    //   print(comments["data"]["children"][i]["body"]);
    // }
    return arr;
  }

  // get
}
