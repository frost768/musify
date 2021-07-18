import 'package:flutter/material.dart';
import 'package:spotify_clone/data/playlists.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/views/views.dart';

class PlayerNarrow extends StatefulWidget {
  Track track;
  PlayerNarrow(Track this.track, {Key? key}) : super(key: key);

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
            flex: 2,
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  widget.track = rap[value];
                  widget.track.isPlaying = true;
                });
              },
              children: rap
                  .map((e) => Container(
                        margin: _margin,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  Text(
                                    widget.track.name,
                                    style: kSongNameStyle,
                                  ),
                                  Text(' '),
                                  Text(
                                    '•',
                                    style: kArtistStyle.copyWith(fontSize: 15),
                                  ),
                                  Text(' '),
                                  Text(
                                    widget.track.artist,
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
                      ))
                  .toList(),
            ),
          ),
          // Like And Play
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.track.liked = !widget.track.liked;
                    });
                  },
                  icon: Icon(
                      widget.track.liked
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: widget.track.liked ? Colors.green : Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.track.isPlaying = !widget.track.isPlaying;
                    });
                  },
                  icon: Icon(
                    widget.track.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
