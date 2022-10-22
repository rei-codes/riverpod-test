import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_test/models/post.dart';
import 'package:riverpod_test/providers/post_provider.dart';
import 'package:riverpod_test/repositories/post_repository.dart';

import '../../mocks.dart';

void main() {
  group('postsProvider -', () {
    test('return AsyncValue<List<Post>> when repo gave the data', () async {
      // ARRANGE
      final mockPostRepository = MockPostRepository();

      when(mockPostRepository.getPosts).thenAnswer((_) async => <Post>[]);

      final container = ProviderContainer(
        overrides: [
          postRepository.overrideWithValue(mockPostRepository),
        ],
      );

      // ASSERT
      expect(container.read(postsProvider), isA<AsyncLoading<List<Post>>>());

      // ACT
      await container.read(postsProvider.future);

      // ASSERT
      expect(container.read(postsProvider), isA<AsyncData<List<Post>>>());

      verify(mockPostRepository.getPosts).called(1);
    });

    test('return AsyncError<List<Post>> when repo throws an exception',
        () async {
      // ARRANGE
      final exception = Exception();

      final mockPostRepository = MockPostRepository();

      when(mockPostRepository.getPosts).thenThrow(exception);

      final container = ProviderContainer(
        overrides: [
          postRepository.overrideWithValue(mockPostRepository),
        ],
      );

      // ASSERT
      expect(
        container.read(postsProvider),
        isA<AsyncError<List<Post>>>()
            .having((e) => e.error, 'error', exception),
      );

      verify(mockPostRepository.getPosts).called(1);
    });
  });

  group('postsProvider -', () {
    test('return AsyncData<Post> correctly', () async {
      // ARRANGE
      final post = Post(id: 1, userId: 1, title: '', body: '');

      final mockPostRepository = MockPostRepository();

      when(() => mockPostRepository.getPost(1)).thenAnswer((_) async => post);

      final container = ProviderContainer(
        overrides: [
          postRepository.overrideWithValue(mockPostRepository),
        ],
      );

      // ASSERT
      expect(container.read(postProvider(1)), isA<AsyncLoading<Post>>());

      // ACT
      await container.read(postProvider(1).future);

      // ASSERT
      expect(
        container.read(postProvider(1)),
        isA<AsyncData<Post>>().having((e) => e.value.id, 'id', post.id),
      );

      verify(() => mockPostRepository.getPost(1)).called(1);
    });

    test('return AsyncError<Post> when repo throws an exception', () async {
      // ARRANGE
      final exception = Exception();

      final mockPostRepository = MockPostRepository();

      when(() => mockPostRepository.getPost(-1)).thenThrow(exception);

      final container = ProviderContainer(
        overrides: [
          postRepository.overrideWithValue(mockPostRepository),
        ],
      );

      // ASSERT
      expect(
        container.read(postProvider(-1)),
        isA<AsyncError<Post>>().having((e) => e.error, 'error', exception),
      );

      verify(() => mockPostRepository.getPost(-1)).called(1);
    });
  });
}
