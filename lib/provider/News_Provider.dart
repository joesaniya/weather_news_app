import 'package:flutter/material.dart';
import 'package:weather_task/modal/NewsArticle.dart';
import 'package:weather_task/service/News_Service.dart';

class NewsProvider with ChangeNotifier {
  List<NewsArticle> _articles = [];
  bool _isLoading = false;

  List<NewsArticle> get articles => _articles;
  bool get isLoading => _isLoading;

  Future<void> fetchNews(String keyword) async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles = await NewsService().fetchNews(keyword);
      notifyListeners();
    } catch (e) {
      _articles = [];
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
