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
  String karmaNumber = "";
  String subsNumber = "";
  String timeInDaySinceCreation = "";
  String dateOfCreation = "";

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
      karmaNumber = apiProfile.getKarma().toString();
      subsNumber = apiProfile.getSubs().toString();
      timeInDaySinceCreation = apiProfile.getTimeSinceCreation();
      dateOfCreation = apiProfile.getDateOfCreation();
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
                          width: 130,
                          height: 130,
                        ),
                        Text(
                          profileName,
                          style: TextStyle(fontSize: 30),
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                karmaNumber + " karma · ",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                timeInDaySinceCreation + " j · ",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                dateOfCreation + " · ",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                subsNumber + " abonné(s)",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        // Center(
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Text(
                        //         karmaNumber,
                        //         style: TextStyle(fontSize: 20),
                        //       )
                        //       Text("salute"),
                        //     ],
                        //   ),
                        // ),
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
