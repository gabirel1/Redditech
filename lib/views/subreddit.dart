import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:redditech/api/endpoints/subreddit.dart';
import 'package:redditech/utils/convert.dart';

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

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var apiSubReddit = APISubreddit(widget.subreddit);
    await apiSubReddit.fetch();
    setState(() {
      about = apiSubReddit.getAbout();
      isLoading = false;
    });
    inspect(this.about);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff202020), title: Text(widget.subreddit)),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  child: CachedNetworkImage(
                    height: 100,
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
                        height: 100,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                this.about['title'],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                this.about['public_description'],
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                              Text(
                                '${convertNumberToStringWithSpaces(this.about['subscribers'])} Members',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
