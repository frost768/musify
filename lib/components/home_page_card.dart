import 'package:flutter/material.dart';
import 'package:spotify_clone/models/album.dart';
import 'package:spotify_clone/views/views.dart';

class HomePageCard extends StatelessWidget {
  Album? album;
  bool showTitle;
  bool showSubtitle;
  HomePageCard(
      {this.album, this.showTitle = false, this.showSubtitle = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        children: [
          if (album != null)
            Container(
              width: 150,
              height: 150,
              child: Image.network(album!.coverBig),
            )
          else
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.purple, Colors.pink])),
            ),
          Container(
              width: 150,
              margin: kMarginTop10,
              height: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (album != null)
                    Text(
                      album!.title,
                    ),
                  if (showTitle)
                    Text(
                      homePageCardSampleTitle,
                    ),
                  if (album == null)
                    Text(
                      homePageCardSampleSubtitle,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                ],
              ))
        ],
      ),
    );
  }
}
