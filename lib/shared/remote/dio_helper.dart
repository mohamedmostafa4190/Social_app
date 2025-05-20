import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl:
            '',
        // headers: {'Content-Type': 'application/json'},
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.get(url, queryParameters: query);
  }

  static void postData({
    required String url,
    required String email,
    required String password,
  }) async {
    return await dio!
        .post(url, data: {'email': email, 'password': password})
        .then((value) {});
  }
}
