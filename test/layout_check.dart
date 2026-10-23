// Явная самопроверка: flutter test test/layout_check.dart
// В незаполненном шаблоне эти проверки ожидаемо не проходят.
import 'package:flutter/material.dart';
import 'font_setup.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:city_layout_task/data.dart';
import 'package:city_layout_task/main.dart';

void viewport(WidgetTester tester, double width) {
  tester.view.physicalSize = Size(width, 640);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Future<void> lastCity(WidgetTester tester, bool grid) async {
  final list = find.byType(grid ? GridView : ListView);
  expect(list, findsOneWidget);
  final scroll = find.descendant(of: list, matching: find.byType(Scrollable));
  await tester.scrollUntilVisible(
    find.byKey(const ValueKey('city-kamchatka')),
    180,
    scrollable: scroll,
    maxScrolls: 30,
  );
  final target = find.byKey(const ValueKey('city-kamchatka'));
  await Scrollable.ensureVisible(tester.element(target), alignment: 1);
  await tester.pumpAndSettle();
  expect(target.hitTestable(), findsOneWidget);
  expect(
    find.descendant(of: target, matching: find.text(cities.last.name)),
    findsOneWidget,
  );
  expect(
    find.descendant(of: target, matching: find.text('7 °C')),
    findsOneWidget,
  );
  await tester.tap(target);
  await tester.pumpAndSettle();
  // Выбор длинного города может увеличить заголовок и уменьшить viewport.
  await Scrollable.ensureVisible(tester.element(target), alignment: 1);
  await tester.pumpAndSettle();
  expect(
    tester.getRect(target).bottom,
    lessThanOrEqualTo(tester.getRect(list).bottom + 1),
  );
  final header = find.byKey(const ValueKey('selected-city'));
  expect(
    find.descendant(of: header, matching: find.text(cities.last.name)),
    findsOneWidget,
  );
  expect(
    find.descendant(of: header, matching: find.text('7 °C')),
    findsOneWidget,
  );
}

void main() {
  setUpAll(loadTestFonts);
  for (final width in [320.0, 800.0]) {
    for (final large in [false, true]) {
      for (final grid in [false, true]) {
        testWidgets(
          '$width px, text ${large ? 1.3 : 1}, ${grid ? "grid" : "list"}',
          (tester) async {
            viewport(tester, width);
            await tester.pumpWidget(const CityApp());
            if (large) {
              await tester.tap(find.byKey(const ValueKey('large-text')));
              await tester.pump();
            }
            if (grid) {
              await tester.tap(find.byKey(const ValueKey('mode-grid')));
              await tester.pump();
            }
            await lastCity(tester, grid);
            expect(tester.takeException(), isNull);
          },
        );
      }
    }
  }
  testWidgets('selection survives changing layout mode', (tester) async {
    viewport(tester, 320);
    await tester.pumpWidget(const CityApp());
    await lastCity(tester, false);
    await tester.tap(find.byKey(const ValueKey('mode-grid')));
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('selected-city')),
        matching: find.text(cities.last.name),
      ),
      findsOneWidget,
    );
    await tester.tap(find.byKey(const ValueKey('mode-list')));
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('selected-city')),
        matching: find.text(cities.last.name),
      ),
      findsOneWidget,
    );
  });
}
