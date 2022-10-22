import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/models/post.dart';

import '../providers/favorites_provider.dart';
import 'details_page.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailsPage(post)),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(post.title),
          subtitle: Text(post.body),
          trailing: Consumer(builder: (_, ref, __) {
            final favs = ref.read(favoritesProvider.notifier);
            final isFavorited = ref.watch(
              favoritesProvider.select((list) => list.contains(post)),
            );
            return IconButton(
              icon: Icon(
                Icons.favorite,
                color: isFavorited ? Colors.red : Colors.grey,
              ),
              onPressed: () => favs.favorite(post),
            );
          }),
        ),
      ),
    );
  }
}
