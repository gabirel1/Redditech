import 'package:flutter/material.dart';

class SubRedditPost extends StatelessWidget {
  final data;

  SubRedditPost({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            data["title"],
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Text(
            data["author"],
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          Text(
            data["subreddit_name_prefixed"],
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          Text(
            data["created"].toString(),
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}