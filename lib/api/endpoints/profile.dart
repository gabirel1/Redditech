import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:redditech/api/utils.dart';

class APIProfile {
  var data;
  var comments;
  var posts;

  APIProfile();

  fetch() async {
    var response = await getAPI("me", v1: true);
    try {
      data = jsonDecode(response.body);
      var response2 = await getAPI("user/" + data["name"] + "/comments");
      comments = jsonDecode(response2.body);
      var response3 = await getAPI("user/" + data["name"] + "/submitted");
      posts = jsonDecode(response3.body);
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
    // print("url == $bannerURL");
    return bannerURL.replaceAll("amp;", "");
  }

  getBannerSize() {
    return data["subreddit"]["banner_size"];
  }

  getKarma() {
    return data["total_karma"];
  }

  getPostKarma() {
    // might not be the good one but it's the only plausible one atm
    return data["link_karma"];
  }

  getCommentKarma() {
    return data["comment_karma"];
  }

  getAwarderKarma() {
    return data["awarder_karma"];
  }

  getAwardeeKarma() {
    return data["awardee_karma"];
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

  getComments() {
    List arr = [];
    print(comments["data"]["dist"]);
    for (int i = 0; i < comments["data"]["dist"]; i++) {
      arr.add(comments["data"]["children"][i]["data"]);
      // var body = comments["data"]["children"][i]["data"]["body"];
      // print("body == $body");
    }
    return arr;
  }

  getPosts() {
    List arr = [];
    for (int i = 0; i < posts["data"]["children"].length; i++) {
      arr.add(posts["data"]["children"][i]["data"]);
    }
    return arr;
  }
  // get
}
