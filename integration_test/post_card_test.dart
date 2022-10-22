import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:riverpod_test/main.dart' as app;
import 'package:riverpod_test/pages/post_card.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('PostCard - click on it and expect it navigates to detailspage',
      (tester) async {
    // runs the app
    app.main();

    // runs the app
    await tester.pumpAndSettle();

    expect(find.byType(ListView), findsOneWidget);

    final button = find.byType(PostCard).first;

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.text('Details'), findsOneWidget);
  });
}
