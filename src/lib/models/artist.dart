class Artist {
  Artist({
    required this.id,
    required this.name,
    this.link = '',
    this.picture = '',
    this.pictureSmall = '',
    this.pictureMedium = '',
    this.pictureBig = '',
    this.pictureXl = '',
    required this.tracklist,
    this.type = 'album',
  });

  final int id;
  final String name;
  final String? link;
  final String picture;
  final String pictureSmall;
  final String pictureMedium;
  final String pictureBig;
  final String pictureXl;
  final String tracklist;
  final String type;

  factory Artist.fromMap(Map<String, dynamic> json) {
    if (json["picture_big"] == null) {
      return Artist(
          id: json["id"], name: json["name"], tracklist: json["tracklist"]);
    }
    return Artist(
      id: json["id"],
      name: json["name"],
      link: json["link"],
      picture: json["picture"],
      pictureSmall: json["picture_small"],
      pictureMedium: json["picture_medium"],
      pictureBig: json["picture_big"],
      pictureXl: json["picture_xl"],
      tracklist: json["tracklist"],
      type: json["type"],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "link": link,
        "picture": picture,
        "picture_small": pictureSmall,
        "picture_medium": pictureMedium,
        "picture_big": pictureBig,
        "picture_xl": pictureXl,
        "tracklist": tracklist,
        "type": type,
      };
}
