import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/post_repository.dart';

// ### All Posts ###

final postsProvider = FutureProvider((ref) {
  return ref.read(postRepository).getPosts();
});

// ### Selected Post ###

final postProvider = FutureProvider.family.autoDispose((ref, int id) {
  return ref.read(postRepository).getPost(id);
});
