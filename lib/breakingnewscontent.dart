import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_app/breakingnewscontent.dart';
import 'package:news_app/models/breakingnewsmodel.dart';
import 'package:news_app/models/saved_news_model.dart';
import 'package:news_app/news_page.dart';

class BreakingNewsContent extends StatefulWidget {
  final dynamic breakingNewsTitle;
  final dynamic breakingNewsImageUrl;
  final dynamic breakingNewsContent;
  final dynamic breakingNewsDescription;
  final dynamic breakingNewsAuthor;
  final dynamic newsDate;

  BreakingNewsContent(
      {super.key,
      this.breakingNewsTitle,
      this.breakingNewsImageUrl,
      this.breakingNewsContent,
      this.breakingNewsDescription,
      this.newsDate,
      this.breakingNewsAuthor});

  @override
  State<BreakingNewsContent> createState() => _BreakingNewsContentState();
}

class _BreakingNewsContentState extends State<BreakingNewsContent> {
  late Box<SavedNewsModel> savedNewsBox;

  bool isNewsSaved = false;

  @override
  void initState() {
    // TODO: implement initState
    // isNewsSaved = savedNews.contains(
    //   SavedNewsModel(
    //     author: widget.breakingNewsAuthor,
    //     imageUrl: widget.breakingNewsImageUrl,
    //     title: widget.breakingNewsTitle,
    //     publishDate: widget.newsDate,
    //     description: widget.breakingNewsDescription,
    //     content: widget.breakingNewsContent,
    //   ),
    // );
    savedNewsBox = Hive.box<SavedNewsModel>('savedNewsBox');

    super.initState();
  }

  void toggleSave() {
    setState(() {
      isNewsSaved = !isNewsSaved;
    });
    SavedNewsModel savedNewsModel = SavedNewsModel(
      author: widget.breakingNewsAuthor,
      imageUrl: widget.breakingNewsImageUrl,
      title: widget.breakingNewsTitle,
      publishDate: widget.newsDate,
      description: widget.breakingNewsDescription,
      content: widget.breakingNewsContent,
    );

    if (isNewsSaved) {
      savedNewsBox.add(savedNewsModel);
    } else {
      savedNewsBox.deleteAt(
        savedNewsBox.values.toList().indexOf(savedNewsModel),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SavedNewsModel savedNewsModel = SavedNewsModel();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF7F8FC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.03,
            ),
            Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.5,
                ),
                const Icon(
                  Icons.share,
                  size: 30,
                ),
                SizedBox(
                  width: width * 0.05,
                ),
                InkWell(
                  onTap: toggleSave,
                  child: Icon(
                    isNewsSaved
                        ? Icons.bookmark
                        : Icons.bookmark_border_outlined,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: width * 0.05,
                ),
                Icon(
                  Icons.more_vert_rounded,
                  size: 30,
                ),
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            SizedBox(
              height: height * 0.015,
            ),
            widget.breakingNewsImageUrl != null
                ? Container(
                    height: height * 0.27,
                    width: width * 0.98,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.breakingNewsImageUrl!),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            right: width * 0.4,
                          ),
                          child: const Text(
                            "Technology  | TechNews ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          widget.breakingNewsTitle,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                : const CircularProgressIndicator(),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                widget.breakingNewsDescription,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                widget.breakingNewsContent,
                style: const TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
