import 'dart:convert';

import 'package:spotify_clone/models/artist.dart';
import 'package:spotify_clone/models/track.dart';

class AlbumDetail {
  AlbumDetail({
    required this.id,
    required this.title,
    required this.upc,
    required this.link,
    required this.share,
    required this.cover,
    required this.coverSmall,
    required this.coverMedium,
    required this.coverBig,
    required this.coverXl,
    required this.md5Image,
    required this.genreId,
    required this.genres,
    required this.label,
    required this.nbTracks,
    required this.duration,
    required this.fans,
    required this.releaseDate,
    required this.recordType,
    required this.available,
    required this.tracklist,
    required this.explicitLyrics,
    required this.explicitContentLyrics,
    required this.explicitContentCover,
    required this.contributors,
    required this.artist,
    required this.type,
    required this.tracks,
  });

  final int id;
  final String title;
  final String upc;
  final String link;
  final String share;
  final String cover;
  final String coverSmall;
  final String coverMedium;
  final String coverBig;
  final String coverXl;
  final String md5Image;
  final int genreId;
  final Genres genres;
  final String label;
  final int nbTracks;
  final int duration;
  final int fans;
  final DateTime releaseDate;
  final String recordType;
  final bool available;
  final String tracklist;
  final bool explicitLyrics;
  final int explicitContentLyrics;
  final int explicitContentCover;
  final List<Contributor> contributors;
  final Artist artist;
  final String type;
  final Tracks tracks;
  List<Track> get trackList => tracks.data;
  factory AlbumDetail.fromJson(String str) =>
      AlbumDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AlbumDetail.fromMap(Map<String, dynamic> json) => AlbumDetail(
      id: json["id"],
      title: json["title"],
      upc: json["upc"],
      link: json["link"],
      share: json["share"],
      cover: json["cover"],
      coverSmall: json["cover_small"],
      coverMedium: json["cover_medium"],
      coverBig: json["cover_big"],
      coverXl: json["cover_xl"],
      md5Image: json["md5_image"],
      genreId: json["genre_id"],
      genres: Genres.fromMap(json["genres"]),
      label: json["label"],
      nbTracks: json["nb_tracks"],
      duration: json["duration"],
      fans: json["fans"],
      releaseDate: DateTime.parse(json["release_date"]),
      recordType: json["record_type"],
      available: json["available"],
      tracklist: json["tracklist"],
      explicitLyrics: json["explicit_lyrics"],
      explicitContentLyrics: json["explicit_content_lyrics"],
      explicitContentCover: json["explicit_content_cover"],
      contributors: List<Contributor>.from(
          json["contributors"].map((x) => Contributor.fromMap(x))),
      artist: Artist.fromMap(json["artist"]),
      type: json["type"],
      tracks: Tracks.fromMap(json["tracks"]));

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "upc": upc,
        "link": link,
        "share": share,
        "cover": cover,
        "cover_small": coverSmall,
        "cover_medium": coverMedium,
        "cover_big": coverBig,
        "cover_xl": coverXl,
        "md5_image": md5Image,
        "genre_id": genreId,
        "genres": genres.toMap(),
        "label": label,
        "nb_tracks": nbTracks,
        "duration": duration,
        "fans": fans,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "record_type": recordType,
        "available": available,
        "tracklist": tracklist,
        "explicit_lyrics": explicitLyrics,
        "explicit_content_lyrics": explicitContentLyrics,
        "explicit_content_cover": explicitContentCover,
        "contributors": List<dynamic>.from(contributors.map((x) => x.toMap())),
        "artist": artist.toMap(),
        "type": type,
        "tracks": tracks.toMap(),
      };
}

// class Artist {
//   Artist({
//     required this.id,
//     required this.name,
//     required this.picture,
//     required this.pictureSmall,
//     required this.pictureMedium,
//     required this.pictureBig,
//     required this.pictureXl,
//     required this.tracklist,
//     required this.type,
//   });

//   final int id;
//   final String name;
//   final String picture;
//   final String pictureSmall;
//   final String pictureMedium;
//   final String pictureBig;
//   final String pictureXl;
//   final String tracklist;
//   final String type;

//   factory Artist.fromJson(String str) => Artist.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Artist.fromMap(Map<String, dynamic> json) => Artist(
//         id: json["id"],
//         name: json["name"],
//         picture: json["picture"],
//         pictureSmall: json["picture_small"],
//         pictureMedium: json["picture_medium"],
//         pictureBig: json["picture_big"],
//         pictureXl: json["picture_xl"],
//         tracklist: json["tracklist"],
//         type: json["type"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "name": name,
//         "picture": picture,
//         "picture_small": pictureSmall,
//         "picture_medium": pictureMedium,
//         "picture_big": pictureBig,
//         "picture_xl": pictureXl,
//         "tracklist": tracklist,
//         "type": type,
//       };
// }

class Contributor {
  Contributor({
    required this.id,
    required this.name,
    required this.link,
    required this.share,
    required this.picture,
    required this.pictureSmall,
    required this.pictureMedium,
    required this.pictureBig,
    required this.pictureXl,
    required this.radio,
    required this.tracklist,
    required this.type,
    required this.role,
  });

  final int id;
  final String name;
  final String link;
  final String share;
  final String picture;
  final String pictureSmall;
  final String pictureMedium;
  final String pictureBig;
  final String pictureXl;
  final bool radio;
  final String tracklist;
  final String type;
  final String role;

  factory Contributor.fromJson(String str) =>
      Contributor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Contributor.fromMap(Map<String, dynamic> json) => Contributor(
        id: json["id"],
        name: json["name"],
        link: json["link"],
        share: json["share"],
        picture: json["picture"],
        pictureSmall: json["picture_small"],
        pictureMedium: json["picture_medium"],
        pictureBig: json["picture_big"],
        pictureXl: json["picture_xl"],
        radio: json["radio"],
        tracklist: json["tracklist"],
        type: json["type"],
        role: json["role"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "link": link,
        "share": share,
        "picture": picture,
        "picture_small": pictureSmall,
        "picture_medium": pictureMedium,
        "picture_big": pictureBig,
        "picture_xl": pictureXl,
        "radio": radio,
        "tracklist": tracklist,
        "type": type,
        "role": role,
      };
}

class Tracks {
  Tracks({
    required this.data,
  });

  final List<Track> data;

  factory Tracks.fromJson(String str) => Tracks.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tracks.fromMap(Map<String, dynamic> json) => Tracks(
        data: List<Track>.from(json["data"].map((x) => Track.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Genres {
  Genres({
    required this.data,
  });

  final List<AlbumGenre> data;

  factory Genres.fromJson(String str) => Genres.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Genres.fromMap(Map<String, dynamic> json) => Genres(
        data: List<AlbumGenre>.from(
            json["data"].map((x) => AlbumGenre.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class AlbumGenre {
  AlbumGenre({
    required this.id,
    required this.name,
    required this.picture,
    required this.type,
  });

  final int id;
  final String name;
  final String picture;
  final String type;

  factory AlbumGenre.fromJson(String str) =>
      AlbumGenre.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AlbumGenre.fromMap(Map<String, dynamic> json) => AlbumGenre(
        id: json["id"],
        name: json["name"],
        picture: json["picture"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "picture": picture,
        "type": type,
      };
}
