import 'package:spotify_clone/models/search_result.dart';
import 'package:dio/dio.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/services/cache_service.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() {
    return _instance;
  }

  ApiService._internal();
  final Dio _client = Dio(BaseOptions(baseUrl: "https://api.deezer.com"));
  final _ytClient = YoutubeExplode();

  Future<SearchResult> search(String query) async {
    var response = await _client
        .get<Map<String, dynamic>>('/search', queryParameters: {'q': query});
    return SearchResult.fromMap(response.data!);
  }

  Future<SearchResult> nextResults(Uri next) async {
    var response = await _client.getUri<Map<String, dynamic>>(next);
    return SearchResult.fromMap(response.data!);
  }

  Future<CacheEntry> searchOnYoutubeAndGetUrl(Track track) async {
    final response =
        await _ytClient.search.search(track.title + ' ' + track.artist.name);
    String videoId = response.first.id.value;
    if (CacheService().isInCache(videoId)) {
      return CacheService().get(videoId);
    }
    final manifest =
        await _ytClient.videos.streamsClient.getManifest(response.first.id);
    final audio = manifest.audio.withHighestBitrate();
    final savePath = await CacheService().generatePath(videoId);
    _client
        .downloadUri(
      audio.url,
      savePath,
      options: Options(contentType: 'application/octet-stream'),
      onReceiveProgress: (count, total) => print((count / total) * 100),
    )
        .then((value) {
      CacheService().set(videoId, savePath, track.toJson());
    });
    return CacheEntry(videoId, audio.url.toString(), track.toJson());
  }

  String handleRequest(Response response) {
    switch (response.statusCode) {
      case 404:
        return '';
      default:
        return response.data;
    }
  }
}
