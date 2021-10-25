import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:redditech/utils/convert.dart';
import 'package:redditech/views/subreddit.dart';

class SubRedditPost extends StatelessWidget {
  final data;

  SubRedditPost({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff202020),
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8.0, right: 15),
            child: Row(
              children: [
                TextButton(
                  child: Text(
                    data["subreddit_name_prefixed"],
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SubRedditPage(
                                subreddit: data["subreddit_name_prefixed"],
                              )),
                    );
                  },
                ),
                Spacer(),
                // ElevatedButton(onPressed: () => {}, child: Text("Sub"))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
            child: Text(
              "u/" +
                  data["author"] +
                  " · " +
                  timestampToString(data["created"]) +
                  " · " +
                  data["domain"],
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data["title"],
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          if (data["url"].contains(".jpg") || data["url"].contains(".png"))
            CachedNetworkImage(
              imageUrl: data["url"],
              placeholder: (context, url) => (Center(
                child: Image.network(data["thumbnail"], fit: BoxFit.fill),
              )),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
        ],
      ),
    );
  }
}
