import 'package:http/http.dart' as http;
import 'package:redditech/utils/secrets.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<http.Response> fetchAPI(endPoint) async {
  final prefs = await SharedPreferences.getInstance();
  var accessToken = prefs.getString('access_token');
  return http.get(Uri.parse('$redditAPIOAuthBaseURL/$endPoint'), headers: {
    "Authorization": "Bearer $accessToken",
    "User-Agent": "Redditech/1.0.0 (by /u/redditech)"
  });
}
