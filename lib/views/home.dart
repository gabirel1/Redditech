import 'package:flutter/material.dart';
import 'package:redditech/api/endpoints/subreddits.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isLoading = true;
  var subs = [];

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
      subs = apiSubreddits.getPopularSubs();
    });
    print(subs.length);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return CircularProgressIndicator();
    }
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            toolbarHeight: MediaQuery.of(context).size.height * 0.05,
            automaticallyImplyLeading: false,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TabBar(
                  indicatorWeight: 3,
                  tabs: [
                    Text(
                      "Posts",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "Comments",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "About",
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
              Container(
                  child: CustomScrollView(slivers: <Widget>[
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                  return Text("yo");
                }, childCount: subs.length))
              ])),
              Icon(
                Icons.directions_transit,
                color: Colors.white,
                size: 50,
              ),
              Icon(
                Icons.directions_car,
                color: Colors.white,
                size: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
