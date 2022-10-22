import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/post.dart';
import '../services/dio_service.dart';

final postRepository = Provider((ref) => PostRepository(ref));

class PostRepository {
  final Ref ref;
  const PostRepository(this.ref);

  Future<List<Post>> getPosts() async {
    try {
      final res = await ref.read(dioService).get('/posts/');
      final List list = res.data;
      return list.map((e) => Post.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Post> getPost(int id) async {
    try {
      final res = await ref.read(dioService).get('/posts/$id/');
      return Post.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
