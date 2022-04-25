import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../example/main.dart';

import 'package:flutter_sensitive_content/flutter_sensitive_content.dart';

void main() {
  testWidgets('Example widget has a message "Sensitive Data" ', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    final sensitiveDataFinder = find.text("Sensitive Data");
    final publicDataFinder = find.text("Public Data");

    expect(sensitiveDataFinder, findsOneWidget);
  });
}