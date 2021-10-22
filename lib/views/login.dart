import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:redditech/main.dart';
import 'package:redditech/utils/secrets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';

var isLoading = true;

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    initUniLinks();
    checkLogin();
  }

  void checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('access_token');
    var accessToken = prefs.getString('access_token');

    print('accessToken $accessToken');
    if (accessToken != null) {
      print("User already logged in!");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage(title: "Redditech")),
      );
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void login() async {
    FlutterWebBrowser.openWebPage(
        url: Uri.encodeFull(
            "$redditAPIBaseURL/authorize?client_id=$redditClientID&response_type=token&scope=$redditScope&state=$redditState&redirect_uri=$redirectUri"));
  }

  late StreamSubscription _sub;

  Future<void> initUniLinks() async {
    _sub = uriLinkStream.listen((Uri? link) async {
      String linkStr = link.toString();
      if (linkStr.contains('access_token') &&
          link.toString().contains(redirectUri)) {
        var accessToken = linkStr.split('access_token=')[1].split('&')[0];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', accessToken);
        _sub.cancel();
        print('accessToken $accessToken');
        print("User logged in!");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage(title: "Redditech")),
        );
      }
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
    });
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
          backgroundColor: Color(0xff202020),
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  child: Text("Se connecter"),
                  onPressed: () => login(),
                ),
        ));
    // child: WebView(
    //     initialUrl:
    //         "$redditAPIBaseURL/authorize?client_id=$redditClientID&response_type=token&scope=$redditScope&state=$redditState&redirect_uri=$redirectUri",
    //     javascriptMode: JavascriptMode.unrestricted,
    //     userAgent: "random")));
  }
}
