import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_test/services/dio_service.dart';

void main() {
  group('DioService -', () {
    test('Initialized correctly with a correct baseUrl', () {
      // ARRANGE
      final container = ProviderContainer();

      final dio = container.read(dioService);

      // ASSERT
      expect(dio, isA<Dio>());

      expect(dio.options.baseUrl, 'https://jsonplaceholder.typicode.com');
    });
  });
}
