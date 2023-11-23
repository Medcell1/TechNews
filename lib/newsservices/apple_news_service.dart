import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/breakingnewsmodel.dart';

class AppleNewsService {
  List<NewsModel> news = [];

  Future getNews(String formattedDate) async {
    try {
      String url =
          'https://newsapi.org/v2/everything?q=apple&from=$formattedDate&to=$formattedDate&sortBy=popularity&apiKey=821f06b919c94df68ecdf1cc9c865aa7';
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data["articles"]);
        if (data["status"] == "ok") {
          List<dynamic> articles = data["articles"];
          news = articles
              .where((element) =>
          element["urlToImage"] != null &&
              element["description"] != null)
              .map(
                (element) {
              return NewsModel(
                title: element["title"],
                description: element["description"],
                author: element["author"],
                url: element["url"],
                urlToImage: element["urlToImage"],
                publishDate: element["publishedAt"],
                content: element["content"],
              );
            },
          ).toList();
        }
      }
    } catch (e) {
      print('News error: $e');
    }
  }
}
