import 'package:blog_app/model/blog_model.dart';
import 'package:blog_app/repository/blog_repository.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class BlogViewModel extends ChangeNotifier {
  final List<BlogModel> _blogs = <BlogModel>[];
  bool _isLoading = false;
  List<BlogModel> get blogs => _blogs;
  bool get isLoading => _isLoading;

  BlogViewModel() {
    getBlogs();
    listenConnection();
  }

  //TODO: _singleton
  final _blogRepository = BlogRepository();

  Future<void> getBlogs() async {
    _isLoading = true;
    final blogs = await _blogRepository.getBlogs();
    final blogsRange = blogs.getRange(0, 20);
    _blogs.addAll(blogsRange);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addBlog(BlogModel blog) async {
    _isLoading = true;
    _blogs.add(blog);
    await _blogRepository.saveBlogsToLocale(_blogs);
    _isLoading = false;
    notifyListeners();
  }

  void listenConnection() {
    final connectionChecker = InternetConnectionChecker.instance;

    connectionChecker.onStatusChange.listen((InternetConnectionStatus status) {
      if (status == InternetConnectionStatus.connected) {
        getBlogs();
      }
    });
  }

  BlogModel getByName(String title) {
    return _blogs.firstWhere((blg) => blg.title == title);
  }

  Future<void> deleteByTitle(String title) async {
    _blogs.removeWhere((blg) => blg.title == title);
    await _blogRepository.saveBlogsToLocale(_blogs);
    notifyListeners();
  }
}
