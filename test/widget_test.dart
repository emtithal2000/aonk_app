// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/sub_pages/drawer.dart';
import 'package:aonk_app/pages/first_time.dart';


void main() {
  testWidgets('Account deletion test', (WidgetTester tester) async {
    // Initialize GetStorage for testing
    await GetStorage.init();
    
    // Create a mock PagesProvider
    final pagesProvider = PagesProvider();

    // Build the drawer widget wrapped with necessary providers
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<PagesProvider>.value(
              value: pagesProvider,
            ),
          ],
          child: Scaffold(
            drawer: buildDrawer(tester.element(find.byType(MaterialApp))),
          ),
        ),
      ),
    );

    // Open the drawer
    await tester.dragFrom(const Offset(0, 100), const Offset(300, 100));
    await tester.pumpAndSettle();

    // Find and tap the account deletion button
    final accountDeletionButton = find.text('إلغاء التفعيل');
    expect(accountDeletionButton, findsOneWidget);
    await tester.tap(accountDeletionButton);
    await tester.pumpAndSettle();

    // Verify that GetStorage is cleared
    final storage = GetStorage();
    expect(storage.getKeys().length, equals(0));

    // Verify that PagesProvider values are reset
    // Add specific assertions based on your PagesProvider implementation

    // Verify navigation to FirstTime screen
    expect(find.byType(FirstTime), findsOneWidget);
  });
}
