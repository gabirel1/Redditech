import 'package:flutter/material.dart';

var isLoading = true;

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Mon Profil";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          backgroundColor: Colors.deepOrange,
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  child: Text("Se connecter"),
                  onPressed: () => {},
                ),
        ));
    // child: WebView(
    //     initialUrl:
    //         "$redditAPIBaseURL/authorize?client_id=$redditClientID&response_type=token&scope=$redditScope&state=$redditState&redirect_uri=$redirectUri",
    //     javascriptMode: JavascriptMode.unrestricted,
    //     userAgent: "random")));
  }
}
