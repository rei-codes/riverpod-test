import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_test/repositories/post_repository.dart';

//  Dio Mocks

class MockDio extends Mock implements Dio {}

class MockDioResponse<T> extends Mock implements Response<T> {}

class MockDioError extends Mock implements DioError {}

// Route Mocks

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route {}

// Post Mocks

class MockPostRepository extends Mock implements PostRepository {}
