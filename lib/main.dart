import 'package:flutter/material.dart';
import 'package:redditech/api/endpoints/profile.dart';
import 'package:redditech/views/home.dart';
import 'package:redditech/views/login.dart';
import 'package:redditech/views/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Redditech',
      theme:
          ThemeData(primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.black, backgroundColor: Colors.black),
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

  int _selectedIndex = 0;
  static List<StatefulWidget> _widgetOptions = <StatefulWidget>[
    HomePage(),
    HomePage(),
    HomePage(),
  ];

  @override
  void initState() {
    super.initState();
    loadData();
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
    setState(() {
      profileName = apiProfile.getDisplayName();
      profilePicture = apiProfile.getProfilePicture();
      isLoading = false;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MainPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
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
            child: isLoading ? Text("") : Image.network(
              profilePicture,
              height: 30,
              width: 30,
            ),
          ),
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: isLoading
              ? <Widget>[CircularProgressIndicator()]
              : <Widget>[
                  Container(
                      color: Colors.black,
                      child: _widgetOptions.elementAt(_selectedIndex))
                ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff202020),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
