import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_test/models/post.dart';
import 'package:riverpod_test/pages/details_page.dart';
import 'package:riverpod_test/pages/post_card.dart';

import '../../mocks.dart';

void main() {
  group('PostCard -', () {
    testWidgets('navigate to details page', (tester) async {
      registerFallbackValue(FakeRoute());
      // ARRANGE
      final post = Post(id: 1, userId: 1, title: '', body: '');

      final mockObserver = MockNavigatorObserver();

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: PostCard(post),
            navigatorObservers: [mockObserver],
          ),
        ),
      );

      final button = find.byType(PostCard);

      // ASSERT
      expect(button, findsOneWidget);

      // ACT
      await tester.tap(button);
      await tester.pumpAndSettle();

      // ASSERT
      verify(() => mockObserver.didPush(any(), any()));

      expect(find.byType(DetailsPage), findsOneWidget);
    });

    testWidgets('favorite button works correctly', (tester) async {
      // ARRANGE
      final post = Post(id: 1, userId: 1, title: '', body: '');

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: PostCard(post),
          ),
        ),
      );

      final button = find.byType(IconButton);

      // ASSERT
      expect(tester.widget<Icon>(find.byType(Icon)).color, Colors.grey);

      // ACT
      await tester.tap(button);
      await tester.pumpAndSettle();

      // ASSERT
      expect(tester.widget<Icon>(find.byType(Icon)).color, Colors.red);

      // ACT
      await tester.tap(button);
      await tester.pumpAndSettle();

      // ASSERT
      expect(tester.widget<Icon>(find.byType(Icon)).color, Colors.grey);
    });
  });
}
