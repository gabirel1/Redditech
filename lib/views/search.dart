import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:redditech/utils/convert.dart';
import 'package:redditech/views/subreddit.dart';
import '/api/endpoints/search.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key, this.text = ''}) : super(key: key);

  String text;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var searchResults = [];
  var apiSearch = APISearch();

  var isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  search(String query) async {
    var results = await apiSearch.getSearchResults(query);
    setState(() {
      searchResults = results;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff202020),
        automaticallyImplyLeading: false,
        title: Container(
          width: double.infinity,
          height: 40,
          color: Colors.white,
          child: Center(
            child: TextField(
              controller: TextEditingController(text: widget.text),
              autofocus: true,
              decoration: InputDecoration(
                  hintText: 'Search', prefixIcon: Icon(Icons.search)),
              onSubmitted: (String str) {
                widget.text = str;
                setState(() {
                  isLoading = true;
                  searchResults = [];
                  search(str);
                });
              },
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: searchResults.length > 0
            ? CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubRedditPage(
                                      subreddit: searchResults[index]['data']
                                          ["display_name_prefixed"],
                                    )),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                child: CachedNetworkImage(
                                  width: 36,
                                  imageUrl: searchResults[index]['data']
                                          ['icon_img'] ??
                                      'https://www.redditstatic.com/icon.png',
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    searchResults[index]['data']
                                        ['display_name_prefixed'],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    convertNumberToStringWithSpaces(
                                            searchResults[index]['data']
                                                ['subscribers'] ?? 0) +
                                        ' members',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }, childCount: searchResults.length),
                  )
                ],
              )
            : Text("No results"),
      ),
    );
  }
}
