// ### Favorites ###

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/post.dart';

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<Post>>(
  (_) => FavoritesNotifier(),
);

class FavoritesNotifier extends StateNotifier<List<Post>> {
  FavoritesNotifier() : super(<Post>[]);

  void favorite(Post post) {
    if (state.contains(post)) {
      _removeFromFavorites(post);
    } else {
      _addToFavorites(post);
    }
  }

  void _addToFavorites(Post post) => state = [...state, post];

  void _removeFromFavorites(Post post) {
    state.remove(post);
    state = [...state];
  }

  void clear() => state = <Post>[];
}
