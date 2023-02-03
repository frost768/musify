import 'dart:convert';

import 'package:spotify_clone/models/genre.dart';
import 'package:spotify_clone/models/search_result.dart';
import 'package:dio/dio.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/services/cache_service.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class ApiService {
  CacheService _cacheService = CacheService();
  factory ApiService() {
    final _instance = ApiService._();

    return _instance;
  }

  ApiService._();
  final Dio _client = Dio(BaseOptions(baseUrl: "https://api.deezer.com"));
  final _ytClient = YoutubeExplode();
  Future<List<Genre>> getGenres() async {
    if (_cacheService.isInCache('editorial')) {
      return Genre.fromList(
          jsonDecode(_cacheService.get('editorial').trackJson));
    }
    final response = await _client.get<Map<String, dynamic>>('/editorial');
    _cacheService.set('editorial', _cacheService.generatePath('editorial'),
        jsonEncode(response.data!));

    return Genre.fromList(response.data!);
  }

  Future<SearchResult> search(String query) async {
    final response = await _client
        .get<Map<String, dynamic>>('/search', queryParameters: {'q': query});
    return SearchResult.fromMap(response.data!);
  }

  Future<SearchResult> nextResults(Uri next) async {
    var response = await _client.getUri<Map<String, dynamic>>(next);
    return SearchResult.fromMap(response.data!);
  }

  Future<CacheEntry> searchOnYoutubeAndGetUrl(Track track) async {
    final list = [track.title, track.artist.name];
    if (track.explicitLyrics) list.add('explicit');
    final query = list.join(' ');
    final response =
        await _ytClient.search.search(query, filter: TypeFilters.video);
    String videoId = response.first.id.value;
    if (CacheService().isInCache(videoId)) {
      return CacheService().get(videoId);
    }
    final manifest =
        await _ytClient.videos.streamsClient.getManifest(response.first.id);
    final audio = manifest.audio.withHighestBitrate();
    final savePath = _cacheService.generatePath(videoId);
    _client
        .downloadUri(
      audio.url,
      savePath,
      options: Options(contentType: 'application/octet-stream'),
      onReceiveProgress: (count, total) => print((count / total) * 100),
    )
        .then((value) {
      _cacheService.set(videoId, savePath, track.toJson());
    });
    return CacheEntry(videoId, audio.url.toString(), track.toJson());
  }
}

class ClassName extends Interceptor {
  static Response? _cache;

  @override
  onResponse(response, handler) {
    if (response.requestOptions.uri.path == '/editorial') {
      if (_cache == null) {
        _cache = response;
        handler.next(_cache!);
      } else {
        handler.next(_cache!);
      }
    } else
      handler.next(response);
  }
}
