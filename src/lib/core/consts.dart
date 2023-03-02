import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
export 'extensions.dart';

class LyUI extends UINetease {
  LyUI()
      : super(
            lyricAlign: LyricAlign.LEFT,
            defaultSize: 10,
            otherMainSize: 10,
            defaultExtSize: 90,
            lineGap: 10);
  @override
  Color getLyricHightlightColor() {
    return Colors.white;
  }

  @override
  TextStyle getPlayingMainTextStyle() {
    return TextStyle(
        fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white);
  }

  @override
  TextStyle getOtherMainTextStyle() {
    return TextStyle(
        fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white60);
  }
}

const Map<String, String> searchPageChiplist = const {
  '': 'En İyi Sonuçlar',
  'artist': 'Sanatçılar',
  'track': 'Şarkılar',
  'album': 'Albümler',
};
const Map<String, String> libraryChiplist = const {
  'playlist': 'Çalma Listeleri',
  'podcast': "Podcast'ler ve programlar",
  'album': 'Albümler',
  'artist': "Sanatçılar",
};

const kPodcastsAndPrograms = "Podcast'ler ve programlar";
const kMainColor = Color(0xff292929);
const kPlayerNarrowHeight = 55.0;
const kPlayerElapsedTimeNarrowHeight = 2.0;
const kBottomSideItemHeight = 60.0;
const kBottomSideTotalHeight = 130.0;
const kMainBackColor = Color.fromARGB(255, 0, 0, 0);
const kMarginLeft10 = EdgeInsets.only(left: 10);
const kMarginTop10 = EdgeInsets.only(top: 10);
const kPlayerTimeStringStyle = TextStyle(fontSize: 12, color: Colors.grey);

const kTableTitle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
const kLibraryTabStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
const kLibraryHeaderTabStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28);
const kCreatePlayListTitleStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18);
const kCreatePlayListButtonCancelTextStyle =
    TextStyle(color: Colors.white70, fontSize: 13);
const kCreatePlayListButtonCreateTextStyle =
    TextStyle(color: Colors.green, fontSize: 13);
const kCreatePlaylistSearchTextStyle =
    TextStyle(color: Colors.white, fontSize: 30);
