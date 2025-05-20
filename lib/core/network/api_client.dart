import 'package:dio/dio.dart';
import 'package:fluter_test/core/error/exceptions.dart';
import 'api_interceptor.dart';

class ApiClient {
  final Dio dio;

  ApiClient(this.dio) {
    dio.interceptors.add(ApiInterceptor());
    dio.options.baseUrl = 'https://api.github.com';
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Something went wrong');
    }
  }
}
