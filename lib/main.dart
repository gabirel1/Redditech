import 'package:flutter/material.dart';
import 'package:redditech/api/endpoints/profile.dart';
import 'package:redditech/views/login.dart';
import 'package:redditech/views/profile.dart';
import 'package:redditech/views/search.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/endpoints/subreddits.dart';
import 'widgets/subreddit_post.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Redditech',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.black,
          backgroundColor: Colors.black,
          textTheme: TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: Colors.white,
          )),
      home: LoginPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isLoading = true;
  String profileName = "";
  String profilePicture = "";
  var subsBest = [];
  var subsHot = [];
  var subsTop = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadSubs() async {
    APISubreddits apiSubreddits = APISubreddits();
    await apiSubreddits.fetch();
    setState(() {
      isLoading = false;
      subsBest = apiSubreddits.getBestSubs();
      subsHot = apiSubreddits.getHotSubs();
      subsTop = apiSubreddits.getTopSubs();
    });
  }

  void loadData() async {
    APIProfile apiProfile = APIProfile();
    if (!await apiProfile.fetch()) {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('access_token');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
    loadSubs();
    setState(() {
      profileName = apiProfile.getDisplayName();
      profilePicture = apiProfile.getProfilePicture();
    });
  }

  String lastSearchText = '';

  openSearchPage(String text) {
    if (text == lastSearchText)
      return;
    lastSearchText = text;
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => SearchPage(text: text),
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 250),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            width: double.infinity,
            height: 40,
            color: Colors.white,
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Search', prefixIcon: Icon(Icons.search)),
                onTap: () {
                  openSearchPage('');
                },
                onChanged: (text) {
                  openSearchPage(text);
                },
              ),
            ),
          ),
          backgroundColor: Color(0xff202020),
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isLoading)
                    Text("")
                  else
                    Container(
                      margin: const EdgeInsets.only(right: 16.0),
                      child: Image.network(
                        profilePicture,
                        height: 30,
                        width: 30,
                      ),
                    )
                ],
              ),
            ),
          ],
          bottom: TabBar(
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
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : TabBarView(
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
