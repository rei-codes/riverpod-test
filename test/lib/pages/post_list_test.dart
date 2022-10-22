import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_test/models/post.dart';
import 'package:riverpod_test/pages/post_list.dart';
import 'package:riverpod_test/providers/post_provider.dart';

void main() {
  /// BDD Example
  /// Feature: Get data from 'postRepository' and display them on the UI
  /// Scenario: User opens [HomePage]
  group('PostList -', () {
    /// Given: List of posts
    /// When, data is fetching
    /// Then, [PostList] should display a loading widget
    /// When, get an error while fetching the data
    /// Then, [PostList] should display an error message
    testWidgets('list the given data', (WidgetTester tester) async {
      // ARRANGE
      final list = [
        Post(id: 1, userId: 1, title: '', body: ''),
        Post(id: 2, userId: 2, title: '', body: ''),
        Post(id: 3, userId: 2, title: '', body: ''),
      ];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            postsProvider.overrideWithProvider(
              FutureProvider((_) async => list),
            ),
          ],
          child: const MaterialApp(
            home: PostList(),
          ),
        ),
      );

      // ASSERT
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(ListView), findsNothing);

      // ACT
      await tester.pumpAndSettle();

      // ASSERT
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(ListView), findsOneWidget);
    });

    /// Given: an error to throw
    /// When, data is fetching
    /// Then, [PostList] should display a loading widget
    /// When, the data is ready
    /// Then, [PostList] should display a list of posts
    testWidgets('display error', (WidgetTester tester) async {
      // ARRANGE
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            postsProvider.overrideWithProvider(
              FutureProvider((_) => Future.error('error')),
            ),
          ],
          child: const MaterialApp(
            home: PostList(),
          ),
        ),
      );

      // ASSERT
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('error'), findsNothing);

      // ACT
      await tester.pumpAndSettle();

      // ASSERT
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('error'), findsOneWidget);
    });
  });
}
