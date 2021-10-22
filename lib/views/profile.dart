import 'package:flutter/material.dart';
import 'package:redditech/api/endpoints/profile.dart';
import 'package:redditech/utils/convert.dart';
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

  final String title = "Profil";

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
  List commentsList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    APIProfile apiProfile = APIProfile();
    await apiProfile.fetch();
    setState(
      () {
        profileName = apiProfile.getDisplayName();
        profilePicture = apiProfile.getProfilePicture();
        profileBanner = apiProfile.getBannerPicture();
        profileDescription = apiProfile.getDescription();
        karmaNumber = apiProfile.getKarma().toString();
        subsNumber = apiProfile.getSubs().toString();
        timeInDaySinceCreation = apiProfile.getTimeSinceCreation();
        dateOfCreation = apiProfile.getDateOfCreation();
        commentsList = apiProfile.getComments();
        isLoading = false;
      },
    );
  }

  Widget comment() {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    print("tab");
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          commentsList[index]["link_title"],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              commentsList[index]["author"] + " · ",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              timestampToString(
                                      commentsList[index]["created"]) +
                                  " · ",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              commentsList[index]["score"].toString() + " ",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                            Icon(
                              Icons.arrow_upward,
                              color: Colors.orange,
                            ),
                          ],
                        ),
                        Text(
                          commentsList[index]["body"],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: commentsList.length,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(0xff202020),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "settings",
                child: ListTile(
                  leading: Icon(
                    Icons.settings,
                  ),
                  title: Text(
                    "Settings",
                  ),
                ),
              ),
              PopupMenuItem(
                value: "logout",
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                  ),
                  title: Text(
                    "Logout",
                  ),
                ),
              ),
            ],
            onSelected: (String menu) async {
              if (menu == "settings") {
              } else if (menu == "logout") {
                final prefs = await SharedPreferences.getInstance();
                prefs.remove('access_token');
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage(),
                  ),
                  (Route<dynamic> route) => false,
                );
              } else {
                print("cancelled ?");
              }
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: isLoading
              ? [
                  CircularProgressIndicator(),
                ]
              : [
                  Stack(
                    children: [
                      Image.network(
                        profileBanner,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                          ),
                          child: Image.network(
                            profilePicture,
                            width: 160,
                            height: 160,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    profileName,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          karmaNumber + " karma · ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          timeInDaySinceCreation + " d · ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          dateOfCreation + " · ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          subsNumber + " followers",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    profileDescription + '\n',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.46,
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
                                    "Posts",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "Comments",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "About",
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
                            Icon(
                              Icons.directions_transit,
                              color: Colors.white,
                              size: 50,
                            ),
                            comment(),
                            Icon(
                              Icons.directions_car,
                              color: Colors.white,
                              size: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
        ),
      ),
    );
  }
}
