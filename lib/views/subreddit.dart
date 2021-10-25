import 'package:flutter/material.dart';

var text = '';

class SubRedditPage extends StatefulWidget {
  SubRedditPage({Key? key, required this.subreddit}) : super(key: key);

  final String subreddit;

  @override
  _SubRedditPageState createState() => _SubRedditPageState();
}

class _SubRedditPageState extends State<SubRedditPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff202020), title: Text(widget.subreddit)),
    );
  }
}
