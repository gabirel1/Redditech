import 'package:flutter/material.dart';

var text = '';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key, this.text = ''}) : super(key: key);

  final String text;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
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
                // setState(() {
                //   searching = true;
                //   input = str;
                //   callSearchRequest();
                // });
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
        child: Text('Search'),
      ),
    );
  }
}
