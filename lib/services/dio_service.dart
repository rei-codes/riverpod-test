import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioService = Provider((_) {
  const baseUrl = 'https://jsonplaceholder.typicode.com';
  final dio = Dio(BaseOptions(baseUrl: baseUrl));
  return dio;
});
