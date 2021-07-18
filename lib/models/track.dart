class Track {
  int id;
  String name;
  String album;
  String albumArtUrl;
  String artist;
  bool liked;
  bool isPlaying;
  Track(this.id, this.name, this.artist, this.album, this.albumArtUrl,
      {this.liked = false, this.isPlaying = false});
}
