import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_test/pages/home_page.dart';
import 'package:riverpod_test/pages/post_list.dart';

void main() {
  group('HomePage -', () {
    testWidgets('display postlist and home title', (tester) async {
      // ARRANGE
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // ASSERT
      expect(find.text('Home'), findsOneWidget);
      expect(find.byType(PostList), findsOneWidget);
    });
  });
}
