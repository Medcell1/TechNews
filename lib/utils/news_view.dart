import 'package:flutter/material.dart';
import 'package:news_app/breakingnewscontent.dart';


import 'package:news_app/utils/news_tile.dart';
class NewsView extends StatelessWidget {

   NewsView({
    super.key,
    required this.newsService,
  });

  final dynamic newsService;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: newsService.news.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          print(
              'author===>>>>${newsService.news[index].author}');

          return NewsTile(
              date: newsService.news[index].publishDate!,
              author: newsService.news[index].author == null
                  ? 'Author'
                  : newsService.news[index].author!
                  .toUpperCase(),
              title: newsService.news[index].title!,
              imageUrl: newsService.news[index] != null
                  ? newsService.news[index].urlToImage!
                  : 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.bbc.co.uk%2Fnews%2Fin-pictures-56211135&psig=AOvVaw1HVWKBZRIf0IVY-w6ETIhH&ust=1698978026849000&source=images&cd=vfe&ved=0CBIQjRxqFwoTCJiDyb-gpIIDFQAAAAAdAAAAABAE',
              description: newsService.news[index].description!,
              onTap: () {
                print(
                    'title::::::>>>> ${newsService.news[index].title!}');
                print(
                    'image::::::>>>> ${newsService.news[index].urlToImage!}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BreakingNewsContent(
                        newsDate: newsService.news[index].publishDate!,
                        breakingNewsAuthor: newsService.news[index].author!,
                        breakingNewsTitle:
                        newsService.news[index].title!,
                        breakingNewsImageUrl:
                        newsService.news[index].urlToImage!,
                        breakingNewsContent:
                        newsService.news[index].content!,
                        breakingNewsDescription: newsService
                            .news[index].description!,

                      );
                    },
                  ),
                );
              });
        });
  }
}