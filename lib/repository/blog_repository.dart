import 'dart:convert';

import 'package:blog_app/api/blog_api.dart';
import 'package:blog_app/model/blog_model.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlogRepository {
  final String blogsKey = "blogs";
  Future<List<BlogModel>> getBlogs() async {
    final bool isConnected =
        await InternetConnectionChecker.instance.hasConnection;
    if (!isConnected) {
      return await getBlogsFromLocale();
    }

    final response = await BlogApi.getBlogsApi();
    if (response.isSuccess()) {
      return response.getOrDefault([]);
    } else {
      return await getBlogsFromLocale();
    }
  }

  Future<void> saveBlogsToLocale(List<BlogModel> blogs) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = BlogModel.encode(blogs);
    await prefs.setString(blogsKey, encodedData);
  }

  Future<List<BlogModel>> getBlogsFromLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? blogsString = prefs.getString(blogsKey);
    if (blogsString == null) {
      return [];
    }
    final articlesRaw = json.decode(blogsString) as List<dynamic>;
    final articles = articlesRaw
        .map((article) => BlogModel.fromJson(article))
        .toList();
    return articles;
  }
}
