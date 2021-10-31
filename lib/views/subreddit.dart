import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:redditech/api/endpoints/subreddit.dart';
import 'package:redditech/utils/convert.dart';
import 'package:redditech/widgets/subreddit_post_list.dart';

var text = '';

class SubRedditPage extends StatefulWidget {
  SubRedditPage({Key? key, required this.subreddit}) : super(key: key);

  final String subreddit;

  @override
  _SubRedditPageState createState() => _SubRedditPageState();
}

class _SubRedditPageState extends State<SubRedditPage> {
  var isLoading = true;
  var about = {};
  var isSubscribed = false;

  late APISubreddit apiSubReddit;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    this.apiSubReddit = APISubreddit(widget.subreddit);
    await this.apiSubReddit.fetch();
    setState(() {
      about = this.apiSubReddit.getAbout();
      isSubscribed = this.apiSubReddit.isSubscribed();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff202020), title: Text(widget.subreddit)),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: CachedNetworkImage(
                    height: 60,
                    fit: BoxFit.cover,
                    imageUrl: this.about['mobile_banner_image'],
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  color: Color(0xff202020),
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: this.about['icon_img'],
                        height: 80,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 86,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                this.about['title'],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                this
                                    .about['public_description']
                                    .replaceAll('\n', '   '),
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${convertNumberToStringWithSpaces(this.about['subscribers'])} Members',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => {
                          if (!isSubscribed)
                            apiSubReddit.subscribe()
                          else
                            apiSubReddit.unSubscribe(),
                          setState(() {
                            isSubscribed = !isSubscribed;
                          })
                        },
                        child: Text(
                          isSubscribed ? 'Leave' : 'Join',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.64,
                  color: Colors.black,
                  child: DefaultTabController(
                    length: 3,
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.black,
                        toolbarHeight:
                            MediaQuery.of(context).size.height * 0.05,
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
                          SubRedditPostList(
                            loadFunc: (after) async =>
                                await apiSubReddit.fetchPosts("best", after),
                            showSubRedditName: false,
                          ),
                          SubRedditPostList(
                            loadFunc: (after) async =>
                                await apiSubReddit.fetchPosts("hot", after),
                            showSubRedditName: false,
                          ),
                          SubRedditPostList(
                            loadFunc: (after) async =>
                                await apiSubReddit.fetchPosts("top", after),
                            showSubRedditName: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
