import 'package:http/http.dart' as http;
import 'package:redditech/utils/secrets.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<http.Response> getAPI(endPoint, v1) async {
  final prefs = await SharedPreferences.getInstance();
  var accessToken = prefs.getString('access_token');
  var url = v1 ? redditAPIOAuthBaseURL : redditAPIOAuthBaseURL_V2;
  return http.get(Uri.parse('$url/$endPoint'), headers: {
    "Authorization": "Bearer $accessToken",
    "User-Agent": "Redditech/1.0.0 (by /u/redditech)"
  });
}

Future<http.Response> postAPI(endPoint, body, v1) async {
  final prefs = await SharedPreferences.getInstance();
  var accessToken = prefs.getString('access_token');
  var url = v1 ? redditAPIOAuthBaseURL : redditAPIOAuthBaseURL_V2;
  return http.post(Uri.parse('$url/$endPoint'),
      headers: {
        "Authorization": "Bearer $accessToken",
        "User-Agent": "Redditech/1.0.0 (by /u/redditech)"
      },
      body: body);
}

Future<http.Response> patchAPI(endPoint, body, v1) async {
  final prefs = await SharedPreferences.getInstance();
  var accessToken = prefs.getString('access_token');
  var url = v1 ? redditAPIOAuthBaseURL : redditAPIOAuthBaseURL_V2;
  return http.patch(Uri.parse('$url/$endPoint'),
      headers: {
        "Authorization": "Bearer $accessToken",
        "User-Agent": "Redditech/1.0.0 (by /u/redditech)"
      },
      body: body);
}

Future<http.Response> putAPI(endPoint, body, v1) async {
  final prefs = await SharedPreferences.getInstance();
  var accessToken = prefs.getString('access_token');
  var url = v1 ? redditAPIOAuthBaseURL : redditAPIOAuthBaseURL_V2;
  return http.put(Uri.parse('$url/$endPoint'),
      headers: {
        "Authorization": "Bearer $accessToken",
        "User-Agent": "Redditech/1.0.0 (by /u/redditech)"
      },
      body: body);
}

Future<http.Response> deleteAPI(endPoint, body, v1) async {
  final prefs = await SharedPreferences.getInstance();
  var accessToken = prefs.getString('access_token');
  var url = v1 ? redditAPIOAuthBaseURL : redditAPIOAuthBaseURL_V2;
  return http.delete(Uri.parse('$url/$endPoint'),
      headers: {
        "Authorization": "Bearer $accessToken",
        "User-Agent": "Redditech/1.0.0 (by /u/redditech)"
      },
      body: body);
}
