import 'package:flutter/material.dart';
import 'package:spotify_clone/views/views.dart';

class PlayerNarrow extends StatefulWidget {
  PlayerNarrow({Key? key}) : super(key: key);

  @override
  _PlayerNarrowState createState() => _PlayerNarrowState();
}

class _PlayerNarrowState extends State<PlayerNarrow> {
  TextStyle kSongNameStyle =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle kArtistStyle =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey);
  EdgeInsets _margin = const EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kPlayerNarrowHeight,
      color: kMainColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Album Art
          Container(
            width: kPlayerNarrowHeight,
            color: Colors.white,
          ),
          // Song Info
          Expanded(
            flex: 4,
            child: Container(
              margin: _margin,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Text(
                          'Believe',
                          style: kSongNameStyle,
                        ),
                        Text(
                          '*',
                          style: kArtistStyle,
                        ),
                        Text(
                          'Eminem',
                          style: kArtistStyle,
                        )
                      ],
                    ),
                  ),
                  Offstage(
                    child: Text(
                      'Kullanılabilir Cihazlar',
                      style: kSongNameStyle,
                    ),
                  )
                ],
              ),
            ),
          ),
          // Like And Play
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                Icon(Icons.play_arrow, color: Colors.white),
              ],
            ),
          )
        ],
      ),
    );
  }
}
