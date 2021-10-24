import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:redditech/api/utils.dart';

class APISettings {
  var data;

  APISettings();

  fetch() async {
    var response = await getAPI("me/prefs", v1: true);
    print(response);
    try {
      data = jsonDecode(response.body);
    } catch (_) {
      data = [];
      return false;
    }
    return true;
  }

  getDefaultCommentSortSetting() {
    return data["default_comment_sort"];
  }

  getPersonalizeAdsFromPartnersSetting() {
    return data["third_party_site_data_personalized_ads"];
  }

  getPersonalizeRecommendationFromLocationSetting() {
    return data["show_location_based_recommendations"];
  }

  getCountrySetting() {
    return data["country_code"];
  }

  getNextGenerationRecommendations() {
    return data["feed_recommendations_enabled"];
  }

  getActivityRelevantAds() {
    return data["activity_relevant_ads"];
  }

  getPersonalizeRecommendationFromActivityFromPartners() {
    return data["third_party_data_personalized_ads"];
  }

  setPersonalizeRecommendationFromActivityFromPartners(bool value) async {
    try {
      // ignore: unused_local_variable
      var response = await patchAPI(
          "me/prefs",
          jsonEncode(
            {
              "third_party_data_personalized_ads": value,
            },
          ),
          v1: true);
    } catch (_) {
      print("error $_");
    }
  }

  setPersonalizeAdsFromPartnersSetting(bool value) async {
    try {
      // ignore: unused_local_variable
      var response = await patchAPI(
          "me/prefs",
          jsonEncode(
            {
              "third_party_site_data_personalized_ads": value,
            },
          ),
          v1: true);
    } catch (_) {
      print("error $_");
    }
  }

  setPersonalizeRecommendationFromLocationSetting(bool value) async {
    try {
      // ignore: unused_local_variable
      var response = await patchAPI(
          "me/prefs",
          jsonEncode(
            {
              "show_location_based_recommendations": value,
            },
          ),
          v1: true);
    } catch (_) {
      print("error $_");
    }
  }

  setNextGenerationRecommendations(bool value) async {
    try {
      // ignore: unused_local_variable
      var response = await patchAPI(
          "me/prefs",
          jsonEncode(
            {
              "feed_recommendations_enabled": value,
            },
          ),
          v1: true);
    } catch (_) {
      print("error $_");
    }
  }

  setActivityRelevantAds(bool value) async {
    try {
      // ignore: unused_local_variable
      var response = await patchAPI(
          "me/prefs",
          jsonEncode(
            {
              "activity_relevant_ads": value,
            },
          ),
          v1: true);
    } catch (_) {
      print("error $_");
    }
  }
}
