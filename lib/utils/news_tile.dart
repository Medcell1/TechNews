import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsTile extends StatelessWidget {
  final dynamic article;
  final dynamic imageUrl;
  final dynamic title;
  final dynamic author;
  final dynamic date;
  final dynamic onTap;
  final dynamic description;

  const NewsTile(
      {super.key,
      this.article,
      this.title,
      this.imageUrl,
      this.description,
      this.onTap,
      this.author,
      this.date});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 10, top: 10),
        height: height * 0.25,
        width: width * 0.95,
        child: Card(
          child: Expanded(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 12, top: 10),
                    child: Text(
                      author,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.oswald(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 12 , bottom: 10),
                              child: Text(
                                title,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            // Text(
                            //   description,
                            //   style: TextStyle(color: Colors.black),
                            //   overflow: TextOverflow.ellipsis,
                            //   maxLines: 2,
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 0),
                      height: height * 0.16,
                      width: width * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(imageUrl), fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 10,

                    ),
                    child: Text(date),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
