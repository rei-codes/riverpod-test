import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_test/models/post.dart';
import 'package:riverpod_test/providers/favorites_provider.dart';

void main() {
  group('FavoritesProvider -', () {
    test('add and remove favorites', () {
      // ARRANGE
      final post1 = Post(id: 1, userId: 1, title: '', body: '');
      final post2 = Post(id: 2, userId: 2, title: '', body: '');

      final container = ProviderContainer();
      final provider = container.read(favoritesProvider.notifier);

      // ASSERT
      expect(container.read(favoritesProvider), <Post>[]);

      // ACT
      provider.favorite(post1);
      // ASSERT
      expect(container.read(favoritesProvider), <Post>[post1]);

      // ACT
      provider.favorite(post2);
      // ASSERT
      expect(container.read(favoritesProvider), <Post>[post1, post2]);

      // ACT
      provider.favorite(post2);
      // ASSERT
      expect(container.read(favoritesProvider), <Post>[post1]);
    });

    test('clear favorites', () {
      // ARRANGE
      final post = Post(id: 1, userId: 1, title: '', body: '');

      final container = ProviderContainer();
      final provider = container.read(favoritesProvider.notifier);

      // ASSERT
      expect(container.read(favoritesProvider), <Post>[]);

      // ACT
      provider.favorite(post);
      // ASSERT
      expect(container.read(favoritesProvider), <Post>[post]);

      // ACT
      provider.clear();
      // ASSERT
      expect(container.read(favoritesProvider), <Post>[]);
    });
  });
}
