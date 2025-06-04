import 'package:dio/dio.dart';

class BaseApi {
  BaseApi._singleton();
  static final BaseApi instance = BaseApi._singleton();

  final dio = Dio(BaseOptions(baseUrl: "https://newsapi.org/v2"));
}

final myInstance = BaseApi.instance;
final myDio = BaseApi.instance.dio;
