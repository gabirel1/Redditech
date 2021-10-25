import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:redditech/api/endpoints/subreddits.dart';
import 'package:redditech/widgets/subreddit_post.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isLoading = true;
  var subsBest = [];
  var subsHot = [];
  var subsTop = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    APISubreddits apiSubreddits = APISubreddits();
    await apiSubreddits.fetch();
    setState(() {
      isLoading = false;
      subsBest = apiSubreddits.getBestSubs();
      subsHot = apiSubreddits.getHotSubs();
      subsTop = apiSubreddits.getTopSubs();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return CircularProgressIndicator();
    }
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            toolbarHeight: MediaQuery.of(context).size.height * 0.04,
            automaticallyImplyLeading: false,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TabBar(
                  indicatorWeight: 3,
                  tabs: [
                    Text(
                      "Bests",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "Hots",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "Tops",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          backgroundColor: Colors.black,
          body: TabBarView(
            children: <Widget>[
              CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                    return SubRedditPost(data: subsBest[index]["data"]);
                  }, childCount: subsBest.length))
                ],
              ),
              CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return SubRedditPost(data: subsHot[index]["data"]);
                    }, childCount: subsHot.length),
                  )
                ],
              ),
              CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return SubRedditPost(data: subsTop[index]["data"]);
                    }, childCount: subsTop.length),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
