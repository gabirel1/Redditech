import 'package:http/http.dart' as http;
import 'package:redditech/utils/secrets.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<http.Response> getAPI(endPoint) async {
  final prefs = await SharedPreferences.getInstance();
  var accessToken = prefs.getString('access_token');
  return http.get(Uri.parse('$redditAPIOAuthBaseURL/$endPoint'), headers: {
    "Authorization": "Bearer $accessToken",
    "User-Agent": "Redditech/1.0.0 (by /u/redditech)"
  });
}

Future<http.Response> postAPI(endPoint, body) async {
  final prefs = await SharedPreferences.getInstance();
  var accessToken = prefs.getString('access_token');
  return http.post(Uri.parse('$redditAPIOAuthBaseURL/$endPoint'),
      headers: {
        "Authorization": "Bearer $accessToken",
        "User-Agent": "Redditech/1.0.0 (by /u/redditech)"
      },
      body: body);
}

Future<http.Response> patchAPI(endPoint, body) async {
  final prefs = await SharedPreferences.getInstance();
  var accessToken = prefs.getString('access_token');
  return http.patch(Uri.parse('$redditAPIOAuthBaseURL/$endPoint'),
      headers: {
        "Authorization": "Bearer $accessToken",
        "User-Agent": "Redditech/1.0.0 (by /u/redditech)"
      },
      body: body);
}

Future<http.Response> putAPI(endPoint, body) async {
  final prefs = await SharedPreferences.getInstance();
  var accessToken = prefs.getString('access_token');
  return http.put(Uri.parse('$redditAPIOAuthBaseURL/$endPoint'),
      headers: {
        "Authorization": "Bearer $accessToken",
        "User-Agent": "Redditech/1.0.0 (by /u/redditech)"
      },
      body: body);
}

Future<http.Response> deleteAPI(endPoint, body) async {
  final prefs = await SharedPreferences.getInstance();
  var accessToken = prefs.getString('access_token');
  return http.delete(Uri.parse('$redditAPIOAuthBaseURL/$endPoint'),
      headers: {
        "Authorization": "Bearer $accessToken",
        "User-Agent": "Redditech/1.0.0 (by /u/redditech)"
      },
      body: body);
}
