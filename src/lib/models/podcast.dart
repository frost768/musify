import 'dart:convert';

class Podcast {
  Podcast({
    required this.id,
    required this.title,
    required this.description,
    required this.available,
    required this.fans,
    required this.link,
    required this.share,
    required this.picture,
    required this.pictureSmall,
    required this.pictureMedium,
    required this.pictureBig,
    required this.pictureXl,
    required this.type,
  });

  final int id;
  final String title;
  final String description;
  final bool available;
  final int fans;
  final String link;
  final String share;
  final String picture;
  final String pictureSmall;
  final String pictureMedium;
  final String pictureBig;
  final String pictureXl;
  final String type;

  Podcast copyWith({
    int? id,
    String? title,
    String? description,
    bool? available,
    int? fans,
    String? link,
    String? share,
    String? picture,
    String? pictureSmall,
    String? pictureMedium,
    String? pictureBig,
    String? pictureXl,
    String? type,
  }) =>
      Podcast(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        available: available ?? this.available,
        fans: fans ?? this.fans,
        link: link ?? this.link,
        share: share ?? this.share,
        picture: picture ?? this.picture,
        pictureSmall: pictureSmall ?? this.pictureSmall,
        pictureMedium: pictureMedium ?? this.pictureMedium,
        pictureBig: pictureBig ?? this.pictureBig,
        pictureXl: pictureXl ?? this.pictureXl,
        type: type ?? this.type,
      );

  factory Podcast.fromJson(String str) => Podcast.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Podcast.fromMap(Map<String, dynamic> json) => Podcast(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        available: json["available"],
        fans: json["fans"],
        link: json["link"],
        share: json["share"],
        picture: json["picture"],
        pictureSmall: json["picture_small"],
        pictureMedium: json["picture_medium"],
        pictureBig: json["picture_big"],
        pictureXl: json["picture_xl"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "available": available,
        "fans": fans,
        "link": link,
        "share": share,
        "picture": picture,
        "picture_small": pictureSmall,
        "picture_medium": pictureMedium,
        "picture_big": pictureBig,
        "picture_xl": pictureXl,
        "type": type,
      };
}
