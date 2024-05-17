import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/article_model.dart';

class ApiService {
  static Future<List<Article>> getArticlesByCategory(String category) async {
    String apiKey = 'fad645eba2c04be5a9e637ec40eb8b12';
    String url =
        'https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=$apiKey';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return (data['articles'] as List)
          .map((e) => Article.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
