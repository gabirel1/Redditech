import 'package:flutter/material.dart';
import 'package:redditech/api/endpoints/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

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

  final String title = "Mon Profile";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String profileName = "";
  String profilePicture = "";
  String profileBanner = "";
  String profileDescription = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    APIProfile apiProfile = APIProfile();
    await apiProfile.fetch();
    setState(() {
      profileName = apiProfile.getDisplayName();
      profilePicture = apiProfile.getProfilePicture();
      profileBanner = apiProfile.getBannerPicture();
      profileDescription = apiProfile.getDescription();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.deepOrange,
        ),
        body: Center(
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: isLoading
                    ? [CircularProgressIndicator()]
                    : [
                        Image.network(
                          profileBanner,
                          // height: 384,
                          // width: 1280,
                        ),
                        Image.network(
                          profilePicture,
                          width: 65,
                          height: 65,
                        ),
                        Text(
                          profileName,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          profileDescription,
                        ),
                        ElevatedButton(
                          child: Text('Logout'),
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.remove('access_token');
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        LoginPage()),
                                (Route<dynamic> route) => false);
                          },
                        ),
                      ])));
  }
}
