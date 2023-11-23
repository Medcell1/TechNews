import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/breakingnewscontent.dart';
import 'package:news_app/models/breakingnewsmodel.dart';
import 'package:news_app/newsservices/apple_news_service.dart';
import 'package:news_app/newsservices/business_news_service.dart';
import 'package:news_app/newsservices/wallstreetjournalservice.dart';
import 'package:news_app/newsservices/tesla_news_service.dart';
import 'package:news_app/utils/news_view.dart';
import 'package:news_app/models/saved_news_model.dart';
List <SavedNewsModel> savedNews = [];

class NewsPage extends StatefulWidget {

  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
 NewsModel? breakingNewsModel;
  String date = formatDate(DateTime.now(), [yy, '-', m, '-', d]);
  WallStreetJournalService wsj = WallStreetJournalService();
  TeslaNewsService tns = TeslaNewsService();
  BusinessNewsService bns = BusinessNewsService();
  AppleNewsService ans = AppleNewsService();
  String wsjText = 'Wall Street Journal';
  String teslaText = 'Tesla';
  String businessText = 'Business';
  String appleText = 'Apple';

  Future<void> loadWallStreetJournalNews() async {
    await wsj.getNews();

    setState(() {});
  }

  Future<void> loadTeslaNews() async {
    await tns.getNews(date);

    setState(() {});
  }

  Future<void> loadBusinessNews() async {
    await bns.getNews();
    setState(() {});
  }

  Future<void> loadAppleNews() async {
    await ans.getNews(date);
    setState(() {});
  }

  @override
  void initState() {
    loadWallStreetJournalNews();
    loadTeslaNews();
    loadBusinessNews();
    loadAppleNews();
    super.initState();
  }
loadWallStreetJournal() {

}
  @override
  Widget build(BuildContext context) {
    print('datetime.now====>>>>${DateTime.now()}');

    print('date===>>>${formatDate(DateTime.now(), [yy, '-', m, '-', d])}');
    print("TNSNEWS===>>>>${tns.news}");
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: Text(
          'Tech News',
          style: GoogleFonts.eduTasBeginner(
            textStyle: const TextStyle(
              fontSize: 35,
            ),
          ),
        ),
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            TabBar(
              labelPadding: EdgeInsets.zero,
              tabs: [
                Tab(
                  text: wsjText,
                ),
                Tab(
                  text: teslaText,
                ),
                Tab(
                  text: businessText,
                ),
                Tab(
                  text: appleText,
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  wsj.news.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : NewsView(newsService: wsj),
                  tns.news.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : NewsView(newsService: tns),
                  tns.news.isEmpty
                      ? CircularProgressIndicator()
                      : NewsView(newsService: bns),
                  ans.news.isEmpty
                      ? CircularProgressIndicator()
                      : NewsView(newsService: ans)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
