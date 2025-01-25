import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_task/modal/NewsArticle.dart';
import 'package:weather_task/service/News_Service.dart';

class NewsProvider with ChangeNotifier {
  List<NewsArticle> _articles = [];
  bool _isLoading = false;

  List<NewsArticle> get articles => _articles;
  bool get isLoading => _isLoading;

  List<String> _selectedCategories = [];
  List<String> get selectedCategories => _selectedCategories;
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

  /* Future<void> fetchNews(String keyword) async {
    _isLoading = true;
    notifyListeners();

    try {
      final categoryQuery = _selectedCategories.isNotEmpty
          ? '&category=${_selectedCategories.join(',')}'
          : '';
      final fullKeyword = keyword + categoryQuery;

      _articles = await NewsService().fetchNews(fullKeyword);
      notifyListeners();
    } catch (e) {
      _articles = [];
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
*/
  void toggleCategory(String category) {
    _selectedCategories.clear();
    _selectedCategories.add(category);
    notifyListeners();
  }

  void toggleCategoryy(String category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
    notifyListeners();
  }

  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
