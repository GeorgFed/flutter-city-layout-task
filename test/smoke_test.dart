import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:city_layout_task/main.dart';
import 'package:city_layout_task/layout.dart';

void main() {
  testWidgets('starter launches before the layout is implemented', (
    tester,
  ) async {
    await tester.pumpWidget(const CityApp());
    expect(find.byType(CityScreen), findsOneWidget);
    expect(find.text('Города'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('large-text')));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
}
