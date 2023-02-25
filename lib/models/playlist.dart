import 'dart:convert';

class Playlist {
  Playlist({
    required this.id,
    required this.title,
    required this.public,
    required this.nbTracks,
    required this.link,
    required this.picture,
    required this.pictureSmall,
    required this.pictureMedium,
    required this.pictureBig,
    required this.pictureXl,
    required this.checksum,
    required this.tracklist,
    required this.creationDate,
    required this.md5Image,
    required this.pictureType,
    required this.user,
    required this.type,
  });

  final int id;
  final String title;
  final bool public;
  final int nbTracks;
  final String link;
  final String picture;
  final String pictureSmall;
  final String pictureMedium;
  final String pictureBig;
  final String pictureXl;
  final String checksum;
  final String tracklist;
  final DateTime creationDate;
  final String md5Image;
  final String pictureType;
  final User user;
  final String type;

  Playlist copyWith({
    int? id,
    String? title,
    bool? public,
    int? nbTracks,
    String? link,
    String? picture,
    String? pictureSmall,
    String? pictureMedium,
    String? pictureBig,
    String? pictureXl,
    String? checksum,
    String? tracklist,
    DateTime? creationDate,
    String? md5Image,
    String? pictureType,
    User? user,
    String? type,
  }) =>
      Playlist(
        id: id ?? this.id,
        title: title ?? this.title,
        public: public ?? this.public,
        nbTracks: nbTracks ?? this.nbTracks,
        link: link ?? this.link,
        picture: picture ?? this.picture,
        pictureSmall: pictureSmall ?? this.pictureSmall,
        pictureMedium: pictureMedium ?? this.pictureMedium,
        pictureBig: pictureBig ?? this.pictureBig,
        pictureXl: pictureXl ?? this.pictureXl,
        checksum: checksum ?? this.checksum,
        tracklist: tracklist ?? this.tracklist,
        creationDate: creationDate ?? this.creationDate,
        md5Image: md5Image ?? this.md5Image,
        pictureType: pictureType ?? this.pictureType,
        user: user ?? this.user,
        type: type ?? this.type,
      );

  factory Playlist.fromJson(String str) => Playlist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Playlist.fromMap(Map<String, dynamic> json) => Playlist(
        id: json["id"],
        title: json["title"],
        public: json["public"],
        nbTracks: json["nb_tracks"],
        link: json["link"],
        picture: json["picture"],
        pictureSmall: json["picture_small"],
        pictureMedium: json["picture_medium"],
        pictureBig: json["picture_big"],
        pictureXl: json["picture_xl"],
        checksum: json["checksum"],
        tracklist: json["tracklist"],
        creationDate: DateTime.parse(json["creation_date"]),
        md5Image: json["md5_image"],
        pictureType: json["picture_type"],
        user: User.fromMap(json["user"]),
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "public": public,
        "nb_tracks": nbTracks,
        "link": link,
        "picture": picture,
        "picture_small": pictureSmall,
        "picture_medium": pictureMedium,
        "picture_big": pictureBig,
        "picture_xl": pictureXl,
        "checksum": checksum,
        "tracklist": tracklist,
        "creation_date": creationDate.toIso8601String(),
        "md5_image": md5Image,
        "picture_type": pictureType,
        "user": user.toMap(),
        "type": type,
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.tracklist,
    required this.type,
  });

  final int id;
  final String name;
  final String tracklist;
  final String type;

  User copyWith({
    int? id,
    String? name,
    String? tracklist,
    String? type,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        tracklist: tracklist ?? this.tracklist,
        type: type ?? this.type,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        tracklist: json["tracklist"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "tracklist": tracklist,
        "type": type,
      };
}
