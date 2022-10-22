import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_test/models/post.dart';
import 'package:riverpod_test/pages/details_page.dart';

void main() {
  group('DetailsPage -', () {
    testWidgets('display title of post', (tester) async {
      // ARRANGE
      final post = Post(id: 1, userId: 1, title: '', body: '');

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: DetailsPage(post),
          ),
        ),
      );

      // ASSERT
      expect(find.text(post.title), findsOneWidget);
    });
  });
}
