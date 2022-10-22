import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_test/models/post.dart';
import 'package:riverpod_test/repositories/post_repository.dart';
import 'package:riverpod_test/services/dio_service.dart';

import '../../mocks.dart';

void main() {
  group('PostRepository -', () {
    test('getPosts - return List<Post> with given JSON data', () async {
      // ARRANGE
      final jsonResponse = {'userId': 1, 'id': 1, 'title': '', 'body': ''};

      final mockDio = MockDio();
      final mockResponse = MockDioResponse();

      when(() => mockResponse.data).thenReturn([jsonResponse]);
      when(() => mockDio.get(any())).thenAnswer((_) async => mockResponse);

      final container = ProviderContainer(
        overrides: [
          dioService.overrideWithValue(mockDio),
        ],
      );

      // ACT
      final result = await container.read(postRepository).getPosts();

      // ASSERT
      expect(
        result,
        isA<List<Post>>()
            .having((list) => list.first.id, 'first element id', 1),
      );

      verify(() => mockDio.get('/posts/')).called(1);
    });

    test('getPosts - get an exception from dio and rethrow it', () async {
      // ARRANGE
      final mockDio = MockDio();
      final mockError = MockDioError();

      when(() => mockDio.get(any())).thenThrow(mockError);

      final container = ProviderContainer(
        overrides: [
          dioService.overrideWithValue(mockDio),
        ],
      );

      expect(
        // ACT
        () async => await container.read(postRepository).getPosts(),
        // ASSERT
        throwsA(isA<DioError>()),
      );

      verify(() => mockDio.get('/posts/')).called(1);
    });

    test('getPost - convert and return the fetched data as a Post object',
        () async {
      // ARRANG
      final jsonResponse = {'userId': 1, 'id': 1, 'title': '', 'body': ''};

      final mockDio = MockDio();
      final mockResponse = MockDioResponse();

      when(() => mockResponse.data).thenReturn(jsonResponse);
      when(() => mockDio.get(any())).thenAnswer((_) async => mockResponse);

      final container = ProviderContainer(
        overrides: [
          dioService.overrideWithValue(mockDio),
        ],
      );

      // ACT
      final result = await container.read(postRepository).getPost(1);

      // ASSERT
      expect(result, isA<Post>().having((e) => e.id, 'id', 1));

      verify(() => mockDio.get('/posts/1/')).called(1);
    });

    test('getPost - rethrow the catched exception', () async {
      // ARRANGE
      final mockDio = MockDio();
      final mockError = MockDioError();

      when(() => mockDio.get(any())).thenThrow(mockError);

      final container = ProviderContainer(
        overrides: [
          dioService.overrideWithValue(mockDio),
        ],
      );

      expect(
        // ACT
        () async => await container.read(postRepository).getPost(1),
        // ASSERT
        throwsA(isA<DioError>()),
      );

      verify(() => mockDio.get('/posts/1/')).called(1);
    });
  });
}
