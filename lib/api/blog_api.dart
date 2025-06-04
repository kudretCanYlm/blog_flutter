import 'package:blog_app/api/base_api.dart';
import 'package:blog_app/model/blog_model.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

class BlogApi {
  static Future<Result<List<BlogModel>>> getBlogsApi() async {
    try {
      final response = await myDio.get(
        "/everything?q=apple&from=2025-06-03&to=2025-06-03&sortBy=popularity&apiKey=3f960a4cb9d7404dba8ee06e1a93557d",
      );
      //TODO
      final articlesRaw = response.data["articles"] as List<dynamic>;
      final articles = articlesRaw
          .map((article) => BlogModel.fromJson(article))
          .toList();
      return Success(articles);
    } on DioException catch (e) {
      return Failure(e);
    }
  }
}
