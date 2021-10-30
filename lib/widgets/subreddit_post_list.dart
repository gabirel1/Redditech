import 'package:flutter/material.dart';
import 'package:redditech/widgets/subreddit_post.dart';

class SubRedditPostList extends StatefulWidget {
  final posts;
  final showSubRedditName;

  SubRedditPostList(
      {Key? key, required this.posts, this.showSubRedditName = true})
      : super(key: key);

  @override
  _SubRedditPostListState createState() => _SubRedditPostListState();
}

class _SubRedditPostListState extends State<SubRedditPostList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          return SubRedditPost(data: widget.posts[index]["data"], showSubRedditName: widget.showSubRedditName);
        }, childCount: widget.posts.length))
      ],
    );
  }
}
