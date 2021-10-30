import 'dart:developer';

import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:redditech/utils/convert.dart';
import 'package:redditech/views/subreddit.dart';

class SubRedditPost extends StatefulWidget {
  final data;
  final showSubRedditName;

  SubRedditPost({Key? key, required this.data, this.showSubRedditName = true})
      : super(key: key);

  @override
  _SubRedditPostState createState() => _SubRedditPostState();
}

class _SubRedditPostState extends State<SubRedditPost> {
  @override
  void initState() {
    super.initState();
    if (widget.data["title"].contains("Dexter")) {
      inspect(widget.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff202020),
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (widget.showSubRedditName)
            Container(
              padding: EdgeInsets.only(left: 8.0, right: 15),
              child: Row(
                children: [
                  TextButton(
                    child: Text(
                      widget.data["subreddit_name_prefixed"],
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubRedditPage(
                            subreddit: widget.data["subreddit_name_prefixed"],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          Container(
            padding:
                EdgeInsets.only(left: 15.0, right: 15, bottom: 10, top: 10),
            child: Text(
              "u/" +
                  widget.data["author"] +
                  " · " +
                  timestampToString(widget.data["created"]) +
                  " · " +
                  widget.data["domain"],
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.data["title"],
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          if (widget.data["crosspost_parent_list"] == null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.data["is_video"] == true)
                  BetterPlayer.network(
                    widget.data['media']["reddit_video"]["scrubber_media_url"],
                    betterPlayerConfiguration: BetterPlayerConfiguration(
                      aspectRatio: 16 / 9,
                    ),
                  )
                else if (widget.data["url"].contains(".png") ||
                    widget.data["url"].contains(".jpg") ||
                    widget.data["url"].contains(".jpeg") ||
                    widget.data["url"].contains(".gif"))
                  CachedNetworkImage(
                    imageUrl: widget.data["url"],
                    placeholder: (context, url) => (Center(
                      child: Image.network(widget.data["thumbnail"],
                          fit: BoxFit.fill),
                    )),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )
                else if (widget.data["is_gallery"] != null)
                  CarouselSlider(
                    options: CarouselOptions(),
                    items: widget.data["gallery_data"]["items"]
                        .map<Widget>(
                          (item) => new Container(
                            child: Center(
                              child: CachedNetworkImage(
                                imageUrl: "https://i.redd.it/" +
                                    item["media_id"] +
                                    ".jpg",
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  )
              ],
            )
          else
            Container(
              margin: EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(1.0),
              ),
              child: SubRedditPost(
                  data: widget.data["crosspost_parent_list"][0],
                  showSubRedditName: widget.showSubRedditName),
            ),
        ],
      ),
    );
  }
}
