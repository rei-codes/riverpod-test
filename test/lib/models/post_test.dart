import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_test/models/post.dart';

void main() {
  group('Post -', () {
    test('fromJson', () {
      // ARRANGE
      final jsonResponse = {'userId': 1, 'id': 1, 'title': '', 'body': ''};

      // ACT
      final post = Post.fromJson(jsonResponse);

      // ASSERT
      expect(post, isA<Post>().having((e) => e.id, 'id', 1));
    });
    test('toJson', () {
      // ARRANGE
      final postData = Post(id: 1, userId: 1, title: '', body: '');

      // ACT
      final json = postData.toJson();

      // ASSERT
      expect(json, isA<Map<String, dynamic>>().having((e) => e['id'], 'id', 1));
    });
  });
}
