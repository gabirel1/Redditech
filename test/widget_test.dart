// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:redditech/main.dart';
import 'package:redditech/utils/convert.dart';
import 'package:redditech/utils/secrets.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  group("timestamp test", () {
    test('timeStampToString testing Now', () {
      String res =
          timestampToString(DateTime.now().millisecondsSinceEpoch / 1000);
      expect(res, "Now");
    });

    test('timeStampTOString testing m', () {
      String res = timestampToString(
          (DateTime.now().millisecondsSinceEpoch - 120000) / 1000);
      expect(res, "2m");
    });

    test('timeStampTOString testing h', () {
      String res = timestampToString(
          (DateTime.now().millisecondsSinceEpoch - 7200000) / 1000);
      expect(res, "2h");
    });

    test('timeStampTOString testing d', () {
      String res = timestampToString(
          (DateTime.now().millisecondsSinceEpoch - 172800000) / 1000);
      expect(res, "2d");
    });
  });

  group("secrets", () {
    test("secrets1", () {
      final String scope = redditScope;
      expect(scope,
          "identity edit flair history modconfig modflair account modlog modposts modwiki mysubreddits privatemessages read report save submit subscribe vote wikiedit wikiread");
    });

    test("redditAPIBaseURL", () {
      final String baseURL = redditAPIBaseURL;
      expect(baseURL, "https://www.reddit.com/api/v1");
    });

    test("redditAPIOAuthBaseURL", () {
      final String baseURL = redditAPIOAuthBaseURL;
      expect(baseURL, "https://oauth.reddit.com/api/v1");
    });

    test("redditAPIOAuthBaseURL_V2", () {
      final String baseURL = redditAPIOAuthBaseURL_V2;
      expect(baseURL, "https://oauth.reddit.com");
    });
  });

  // group("", () {});
}
