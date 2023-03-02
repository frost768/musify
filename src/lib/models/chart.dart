// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:spotify_clone/models/models.dart';

class Chart {
  List<Track> tracks;
  List<Album> albums;
  List<Podcast> podcasts;
  List<Playlist> playlists;
  Chart({
    required this.tracks,
    required this.albums,
    required this.podcasts,
    required this.playlists,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tracks': tracks.map((x) => x.toMap()).toList(),
      'albums': albums.map((x) => x.toMap()).toList(),
      'podcasts': podcasts.map((x) => x.toMap()).toList(),
      'playlists': playlists.map((x) => x.toMap()).toList(),
    };
  }

  factory Chart.fromMap(Map<String, dynamic> map) {
    return Chart(
      tracks: List<Track>.from(
        (map['tracks'] as List<int>).map<Track>(
          (x) => Track.fromMap(x as Map<String, dynamic>),
        ),
      ),
      albums: List<Album>.from(
        (map['albums'] as List<int>).map<Album>(
          (x) => Album.fromMap(x as Map<String, dynamic>),
        ),
      ),
      podcasts: List<Podcast>.from(
        (map['podcasts'] as List<int>).map<Podcast>(
          (x) => Podcast.fromMap(x as Map<String, dynamic>),
        ),
      ),
      playlists: List<Playlist>.from(
        (map['playlists'] as List<int>).map<Playlist>(
          (x) => Playlist.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Chart.fromJson(String source) =>
      Chart.fromMap(json.decode(source) as Map<String, dynamic>);
}
