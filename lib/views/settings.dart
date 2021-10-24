import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:redditech/api/endpoints/settings.dart';
import 'package:redditech/api/endpoints/subreddits.dart';
import 'package:redditech/widgets/subreddit_post.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  final String title = "Settings";
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var isLoading = true;
  bool personalizeAdsFromPartnersSetting = false;
  bool personalizeRecommendationFromLocationSetting = false;
  bool nextGenerationRecommendations = false;
  bool activityRelevantAds = false;
  bool personalizeRecommendationFromActivityFromPartners = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    APISettings apiSettings = APISettings();
    await apiSettings.fetch();
    setState(() {
      isLoading = false;
      personalizeAdsFromPartnersSetting =
          apiSettings.getPersonalizeAdsFromPartnersSetting();
      personalizeRecommendationFromLocationSetting =
          apiSettings.getPersonalizeRecommendationFromLocationSetting();
      nextGenerationRecommendations =
          apiSettings.getNextGenerationRecommendations();
      activityRelevantAds = apiSettings.getActivityRelevantAds();
      personalizeRecommendationFromActivityFromPartners =
          apiSettings.getPersonalizeRecommendationFromActivityFromPartners();
    });
  }

  Widget mySettings() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(
        top: 10.0,
        left: 15.0,
        right: 10.0,
      ),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Icon(
                  Icons.settings_outlined,
                  color: Colors.grey,
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: Text(
                    "Personalize ads based on information from our partners",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
                Switch(
                  value: personalizeAdsFromPartnersSetting,
                  activeTrackColor: Colors.blueAccent,
                  activeColor: Colors.white,
                  inactiveTrackColor: Colors.grey,
                  onChanged: (value) {
                    setState(
                      () {
                        personalizeAdsFromPartnersSetting = value;
                      },
                    );
                    APISettings().setPersonalizeAdsFromPartnersSetting(value);
                    print(value);
                  },
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(
                left: 35,
              ),
              width: MediaQuery.of(context).size.width * 0.90,
              child: Text(
                "Allow us to use information that our advertising partners send us to show you better ads.",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.settings_outlined,
                  color: Colors.grey,
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 10,
                  ),
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: Text(
                    "Personalize recommandations based on your general location",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
                Switch(
                  value: personalizeRecommendationFromLocationSetting,
                  activeTrackColor: Colors.blueAccent,
                  activeColor: Colors.white,
                  inactiveTrackColor: Colors.grey,
                  onChanged: (value) {
                    setState(
                      () {
                        personalizeRecommendationFromLocationSetting = value;
                      },
                    );
                    APISettings()
                        .setPersonalizeRecommendationFromLocationSetting(value);
                    print(value);
                  },
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(
                left: 35,
              ),
              width: MediaQuery.of(context).size.width * 0.75,
              child: Text(
                "Allow us to use your city, state, or country (based on your IP) to recommend better posts and communities.",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.settings_outlined,
                  color: Colors.grey,
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 10,
                  ),
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: Text(
                    "Enable next-generation recommendations",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
                Switch(
                  value: nextGenerationRecommendations,
                  activeTrackColor: Colors.blueAccent,
                  activeColor: Colors.white,
                  inactiveTrackColor: Colors.grey,
                  onChanged: (value) {
                    setState(
                      () {
                        nextGenerationRecommendations = value;
                      },
                    );
                    APISettings().setNextGenerationRecommendations(value);
                    print(value);
                  },
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(
                left: 35,
              ),
              width: MediaQuery.of(context).size.width * 0.80,
              child: Text(
                "Includes recommended posts within your home feed.",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.settings_outlined,
                  color: Colors.grey,
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 10,
                  ),
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: Text(
                    "Personalize ads based on your Reddit activity",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
                Switch(
                  value: activityRelevantAds,
                  activeTrackColor: Colors.blueAccent,
                  activeColor: Colors.white,
                  inactiveTrackColor: Colors.grey,
                  onChanged: (value) {
                    setState(
                      () {
                        activityRelevantAds = value;
                      },
                    );
                    APISettings().setActivityRelevantAds(value);
                    print(value);
                  },
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(
                left: 35,
              ),
              width: MediaQuery.of(context).size.width * 0.80,
              child: Text(
                "Allow us to use your interactions on Reddit to show you better ads.",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.settings_outlined,
                  color: Colors.grey,
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 10,
                  ),
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: Text(
                    "Personalize recommendations based on your activity with our partners",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
                Switch(
                  value: personalizeRecommendationFromActivityFromPartners,
                  activeTrackColor: Colors.blueAccent,
                  activeColor: Colors.white,
                  inactiveTrackColor: Colors.grey,
                  onChanged: (value) {
                    setState(
                      () {
                        personalizeRecommendationFromActivityFromPartners =
                            value;
                      },
                    );
                    APISettings()
                        .setPersonalizeRecommendationFromActivityFromPartners(
                            value);
                    print(value);
                  },
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(
                left: 35,
              ),
              width: MediaQuery.of(context).size.width * 0.80,
              child: Text(
                "Allow us to use your interactions with sites and apps we partner with to recommend better posts and communities.",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.settings_outlined,
                  color: Colors.grey,
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 10,
                  ),
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: Text(
                    "Personalize recommendations based on your activity with our partners",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
                Switch(
                  value: personalizeRecommendationFromActivityFromPartners,
                  activeTrackColor: Colors.blueAccent,
                  activeColor: Colors.white,
                  inactiveTrackColor: Colors.grey,
                  onChanged: (value) {
                    setState(
                      () {
                        personalizeRecommendationFromActivityFromPartners =
                            value;
                      },
                    );
                    APISettings()
                        .setPersonalizeRecommendationFromActivityFromPartners(
                            value);
                    print(value);
                  },
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(
                left: 35,
              ),
              width: MediaQuery.of(context).size.width * 0.80,
              child: Text(
                "Allow us to use your interactions with sites and apps we partner with to recommend better posts and communities.",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        backgroundColor: Color(0xff202020),
      ),
      body: Center(
        child: Column(
          children: isLoading
              ? [
                  CircularProgressIndicator(),
                ]
              : [
                  mySettings(),
                ],
        ),
      ),
    );
  }
}
