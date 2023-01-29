import 'dart:convert';
import 'dart:math';

import 'package:spotify_clone/models/album.dart';
import 'package:spotify_clone/models/artist.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/services/api_service.dart';

SearchResult searchResultFromMap(String str) =>
    SearchResult.fromMap(json.decode(str));

String searchResultToMap(SearchResult data) => json.encode(data.toMap());

String resolveType(String type) {
  switch (type) {
    case 'artist':
      return 'Sanatçı';
    case 'track':
      return 'Şarkı';
    default:
      return 'Albüm';
  }
}

class SearchResult {
  SearchResult({
    required this.data,
    required this.total,
    required this.next,
  });
  Future<SearchResult> get nextResults {
    if (next != null) {
      return ApiService().nextResults(Uri.parse(next!));
    }
    return Future.value(SearchResult(data: [], total: total, next: next));
  }

  List get all {
    var list = [...data, ...artistList, ...albumList];
    list.shuffle(Random(4));
    return list;
  }

  List<Artist> get artistList {
    Map<int, Artist> temp = {};
    for (var i = 0; i < data.length; i++) {
      for (var j = 0; j < data.length; j++) {
        if (data[i].artist.id != data[j].artist.id)
          temp[data[j].artist.id] = data[j].artist;
      }
    }
    return temp.entries.map((e) => e.value).toList();
  }

  List<Album> get albumList {
    Map<int, Album> temp = {};
    for (var i = 0; i < data.length; i++) {
      for (var j = 0; j < data.length; j++) {
        if (data[i].album.id != data[j].album.id)
          temp[data[j].album.id] = data[j].album;
      }
    }
    return temp.entries.map((e) => e.value).toList();
  }

  final List<Track> data;
  final int total;
  String? next;

  factory SearchResult.fromMap(Map<String, dynamic> json) => SearchResult(
        data: List<Track>.from(json["data"].map((x) => Track.fromMap(x))),
        total: json["total"],
        next: json["next"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "total": total,
        "next": next,
      };
}
