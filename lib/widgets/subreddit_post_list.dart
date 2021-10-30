import 'package:flutter/material.dart';
import 'package:redditech/widgets/subreddit_post.dart';

class SubRedditPostList extends StatefulWidget {
  final posts;
  final showSubRedditName;
  final loadFunc;

  SubRedditPostList(
      {Key? key, required this.posts, this.loadFunc, this.showSubRedditName = true})
      : super(key: key);

  @override
  _SubRedditPostListState createState() => _SubRedditPostListState();
}

class _SubRedditPostListState extends State<SubRedditPostList> {
  var _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels != 0) {
          // Load new posts
          widget.loadFunc();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      slivers: <Widget>[
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          return SubRedditPost(
              data: widget.posts[index]["data"],
              showSubRedditName: widget.showSubRedditName);
        }, childCount: widget.posts.length))
      ],
    );
  }
}
