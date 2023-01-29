import 'dart:convert';

import 'package:spotify_clone/models/album.dart';
import 'package:spotify_clone/models/artist.dart';

class Track {
  Track({
    required this.id,
    required this.readable,
    required this.title,
    required this.titleShort,
    required this.titleVersion,
    required this.link,
    required this.duration,
    required this.rank,
    required this.explicitLyrics,
    required this.explicitContentLyrics,
    required this.explicitContentCover,
    required this.preview,
    required this.md5Image,
    required this.artist,
    required this.album,
    required this.type,
  });
  bool liked = false;
  final int id;
  final bool readable;
  final String title;
  final String titleShort;
  final String? titleVersion;
  final String link;
  int duration;
  final int rank;
  final bool explicitLyrics;
  final int explicitContentLyrics;
  final int explicitContentCover;
  final String preview;
  final String md5Image;
  final Artist artist;
  final Album album;
  final String type;
  String url = '';
  Duration get pDuration => Duration(seconds: duration);
  factory Track.fromMap(Map<String, dynamic> json) => Track(
        id: json["id"],
        readable: json["readable"],
        title: json["title"],
        titleShort: json["title_short"],
        titleVersion: json["title_version"],
        link: json["link"],
        duration: json["duration"],
        rank: json["rank"],
        explicitLyrics: json["explicit_lyrics"],
        explicitContentLyrics: json["explicit_content_lyrics"],
        explicitContentCover: json["explicit_content_cover"],
        preview: json["preview"],
        md5Image: json["md5_image"],
        artist: Artist.fromMap(json["artist"]),
        album: Album.fromMap(json["album"]),
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "readable": readable,
        "title": title,
        "title_short": titleShort,
        "title_version": titleVersion,
        "link": link,
        "duration": duration,
        "rank": rank,
        "explicit_lyrics": explicitLyrics,
        "explicit_content_lyrics": explicitContentLyrics,
        "explicit_content_cover": explicitContentCover,
        "preview": preview,
        "md5_image": md5Image,
        "artist": artist.toMap(),
        "album": album.toMap(),
        "type": type,
      };
  String toJson() => jsonEncode(toMap());
  factory Track.fromJson(String json) => Track.fromMap(jsonDecode(json));
}
