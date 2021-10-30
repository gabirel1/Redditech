import 'dart:convert';

import 'package:redditech/api/utils.dart';

class APISearch {
  APISearch();

  getSearchResults(String query) async {
    var response = await getAPI(
        "api/subreddit_autocomplete_v2?include_profiles=off&include_over_18=off&limit=10&query=" +
            query);
    try {
      var data = jsonDecode(response.body);
      return (data["data"]["children"]);
    } catch (_) {
      return [];
    }
  }
}
