import 'package:flutter/material.dart';
import 'package:redditech/widgets/subreddit_post.dart';

// ignore: must_be_immutable
class SubRedditPostList extends StatefulWidget {
  final showSubRedditName;
  final loadFunc;

  SubRedditPostList({Key? key, this.loadFunc, this.showSubRedditName = true})
      : super(key: key);

  @override
  _SubRedditPostListState createState() => _SubRedditPostListState();
}

class _SubRedditPostListState extends State<SubRedditPostList> {
  var _controller = ScrollController();
  var posts = [];
  var after;

  var isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData(null);
    _controller.addListener(() async {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels != 0) {
          // Load new posts
          loadData(after);
        }
      }
    });
  }

  void loadData(lclAfter) async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    var data = await widget.loadFunc(lclAfter);
    setState(() {
      posts.addAll(data["children"]);
      after = data["after"];
      isLoading = false;
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
              data: posts[index]["data"],
              showSubRedditName: widget.showSubRedditName);
        }, childCount: posts.length)),
        SliverToBoxAdapter(
          child: isLoading
              ? Container(
                  margin: EdgeInsets.only(bottom: 20, top: 20),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(),
        )
      ],
    );
  }
}
