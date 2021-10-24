import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:redditech/api/utils.dart';

class APISettings {
  var data;

  APISettings();

  fetch() async {
    var response = await getAPI("prefs", v1: true);
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
    return data["third_party_data_personalized_ads"];
  }

  getPersonalizeRecommendationFromLocationSetting() {
    return data["show_location_based_recommendations"];
  }

  getCountrySetting() {
    return data["country_code"];
  }
}
