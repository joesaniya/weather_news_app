import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:weather_task/modal/NewsArticle.dart';
import 'package:weather_task/utils/api_key.dart';

class NewsService {
  String _apiKey = News_API_key;
  static const String _baseUrl = 'https://newsapi.org/v2';

  Future<List<NewsArticle>> fetchNews(String keyword) async {
    log('Keyword weatger:$keyword');
    final url = '$_baseUrl/everything?q=$keyword&apiKey=$_apiKey';
    log('Url:$url');
    final response = await http.get(Uri.parse(url));
    log('News:$response');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['articles'] as List)
          .map((article) => NewsArticle.fromJson(article))
          .toList();
    } else {
      throw Exception('Failed to fetch news');
    }
  }
}
