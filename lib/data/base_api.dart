part of 'data.dart';

class BaseApi {
  static Dio dio = Dio(BaseOptions(
    baseUrl: "https://reqres.in/api",
    connectTimeout: const Duration(minutes: 1).inMicroseconds,
    receiveTimeout: const Duration(minutes: 1).inMicroseconds,
  ));
}
