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
  test('timeStampToString testing', () {
    String res =
        timestampToString(DateTime.now().millisecondsSinceEpoch / 1000);
    expect(res, "Now");
  });

  group("getCountryNameFromCode", () async {
    test("getCountryName", () async {
      String res = await getCountryNameFromCountryCode("FR");
      expect(res, "France");
    });

    test("getCountryName2", () async {
      String res = await getCountryNameFromCountryCode("US");
      expect(res, "United Kingdom");
    });
  });
}
