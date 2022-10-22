import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/post_provider.dart';
import 'post_card.dart';

class PostList extends ConsumerWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPosts = ref.watch(postsProvider);

    return asyncPosts.when(
      data: (list) => ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, i) => PostCard(list[i]),
      ),
      error: (_, __) => const Center(child: Text('error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
