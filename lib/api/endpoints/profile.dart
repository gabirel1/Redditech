import 'dart:convert';
import 'dart:ffi';
import 'package:intl/intl.dart';

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

  // get
}
