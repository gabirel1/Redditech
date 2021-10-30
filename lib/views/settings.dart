import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:redditech/api/endpoints/settings.dart';
import 'package:redditech/api/endpoints/subreddits.dart';
import 'package:redditech/utils/convert.dart';
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
  List countries = [];
  String currentSelectedCountryCode = "";
  String currentSelectedCountryName = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    APISettings apiSettings = APISettings();
    await apiSettings.fetch();
    List cntr = await getCountryCodeNameList();
    var countryCode = apiSettings.getCountryCode();
    var countryName = await getCountryNameFromCountryCode(countryCode);

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
      countries = cntr;
      currentSelectedCountryCode = countryCode;
      currentSelectedCountryName = countryName;
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
            InkWell(
              onTap: () => {
                print("salut"),
                _countryEditModalBottomSheets(context),
              },
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 20,
                            left: 10,
                          ),
                          width: MediaQuery.of(context).size.width * 0.70,
                          child: Text(
                            "Country",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Text(
                          currentSelectedCountryCode,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 35,
                      ),
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Text(
                        "This is your primary location.",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
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
        child: isLoading ? CircularProgressIndicator() : mySettings(),
      ),
    );
  }

  void _countryEditModalBottomSheets(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.black,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.8,
        builder: (context, scrollController) => CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(
                      bottom: 2.0,
                    ),
                    padding: EdgeInsets.only(
                      left: 15.0,
                      right: 15,
                      bottom: 10,
                      top: 5,
                    ),
                    color: Color(0xff202020),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              currentSelectedCountryCode =
                                  countries[index]["code"];
                              currentSelectedCountryName =
                                  countries[index]["name"];
                            });
                            APISettings()
                                .setCountryCode(countries[index]["code"]);
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            children: [
                              Radio<String>(
                                value: countries[index]["code"],
                                groupValue: currentSelectedCountryCode,
                                onChanged: (value) {
                                  setState(() {
                                    print("val = $value");
                                    currentSelectedCountryCode = value!;
                                    currentSelectedCountryName =
                                        countries[index]["name"];
                                  });
                                  APISettings()
                                      .setCountryCode(countries[index]["code"]);
                                  Navigator.of(context).pop();
                                },
                              ),
                              Text(
                                countries[index]["name"],
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // ListTile(
                        //   title: Text(
                        //     countries[index]["name"],
                        //     style: TextStyle(
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        //   leading: Radio<String>(
                        //     value: countries[index]["code"],
                        //     groupValue: countries[index]["code"],
                        //     onChanged: (value) {
                        //       setState(() {
                        //         // currentSelectedCountryName = value;
                        //         print("val = $value");
                        //       });
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  );
                },
                childCount: countries.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
