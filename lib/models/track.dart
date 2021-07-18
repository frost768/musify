class Track {
  int id;
  String name;
  String album;
  Duration duration;
  String albumArtUrl;
  String artist;
  bool liked;

  Track(this.id, this.name, this.artist, this.album, this.albumArtUrl,
      {this.liked = false,
      this.duration = const Duration(minutes: 2, seconds: 20)});
}
