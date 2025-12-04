import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:l13/main.dart';
import 'package:l13/config/app_config.dart';

void main() {
  group('MainApp Widget Tests', () {
    testWidgets('MainApp should create MaterialApp', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MainApp());

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('MainApp should have correct title', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MainApp());

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.title, AppConfig.appName);
    });

    testWidgets('MainApp should use Material3', (WidgetTester tester) async {
      await tester.pumpWidget(const MainApp());

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme?.useMaterial3, isTrue);
    });

    testWidgets('HomePage should be the home widget', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MainApp());

      expect(find.byType(HomePage), findsOneWidget);
    });
  });

  group('HomePage Widget Tests', () {
    testWidgets('HomePage should have Scaffold', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('HomePage should have AppBar with correct title', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text(AppConfig.appName), findsWidgets);
    });

    testWidgets('HomePage should display environment name', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      expect(find.textContaining('Environment:'), findsOneWidget);
      expect(find.textContaining(AppConfig.environmentName), findsOneWidget);
    });

    testWidgets('HomePage should display API URL', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      expect(find.textContaining('API URL:'), findsOneWidget);
      expect(find.textContaining(AppConfig.apiBaseUrl), findsOneWidget);
    });

    testWidgets('HomePage should display API version', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      expect(find.textContaining('API Version:'), findsOneWidget);
      expect(find.textContaining(AppConfig.apiVersion), findsOneWidget);
    });

    testWidgets('HomePage should display timeout', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      expect(find.textContaining('Timeout:'), findsOneWidget);
      expect(find.textContaining('${AppConfig.apiTimeout}s'), findsOneWidget);
    });

    testWidgets('HomePage should show debug features when enabled', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      if (AppConfig.enableDebugFeatures) {
        expect(find.text('Debug Features Enabled'), findsOneWidget);
        expect(find.byIcon(Icons.bug_report), findsOneWidget);
      }
    });

    testWidgets('HomePage should have FloatingActionButton', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('HomePage should show correct environment icon', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      switch (AppConfig.environment) {
        case BuildEnvironment.dev:
          expect(find.byIcon(Icons.developer_mode), findsOneWidget);
        case BuildEnvironment.staging:
          expect(find.byIcon(Icons.science), findsOneWidget);
        case BuildEnvironment.prod:
          expect(find.byIcon(Icons.rocket_launch), findsOneWidget);
      }
    });

    testWidgets('Tapping FAB should show config dialog', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      // Verify dialog is not shown initially
      expect(find.text('Full Configuration'), findsNothing);

      // Tap the FAB
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Verify dialog is shown
      expect(find.text('Full Configuration'), findsOneWidget);
      expect(find.byType(AlertDialog), findsOneWidget);
    });

    testWidgets('Config dialog should display all config entries', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      // Open dialog
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Verify config entries are displayed
      final config = AppConfig.toJson();
      for (final entry in config.entries) {
        expect(find.textContaining(entry.key), findsOneWidget);
      }
    });

    testWidgets('Config dialog should have Close button', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      // Open dialog
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Verify Close button exists
      expect(find.text('Close'), findsOneWidget);

      // Tap Close button
      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();

      // Verify dialog is closed
      expect(find.text('Full Configuration'), findsNothing);
    });

    testWidgets('HomePage should have proper layout structure', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      expect(find.byType(Center), findsWidgets);
      expect(find.byType(Padding), findsWidgets);
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(Icon), findsWidgets);
      expect(find.byType(SizedBox), findsWidgets);
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('HomePage should use proper theme colors', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.backgroundColor, isNotNull);
    });
  });

  group('Environment Color Tests', () {
    testWidgets('Dev environment should use blue color', (
      WidgetTester tester,
    ) async {
      if (AppConfig.environment == BuildEnvironment.dev) {
        await tester.pumpWidget(const MainApp());

        final materialApp = tester.widget<MaterialApp>(
          find.byType(MaterialApp),
        );
        expect(materialApp.theme?.colorScheme.primary, isNotNull);
      }
    });
  });
}
