import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CacheService {
  static final CacheService _instance = CacheService._();
  factory CacheService() {
    return _instance;
  }
  clear() {
    _dir.listSync().forEach((file) {
      if (file.statSync().type == FileSystemEntityType.file) {
        file.delete();
      }
    });
    _cache = {};
  }

  CacheService._();
  late Directory _dir;
  Map<String, CacheEntry> _cache = {};
  bool isInCache(String videoId) => _cache.containsKey(videoId);
  CacheEntry get(String videoId) {
    return _cache[videoId]!;
  }

  List<String> get trackList => _cache.entries
      .where((e) => !e.key.contains('editorial') && !e.key.contains('album'))
      .map((e) => e.value.trackJson)
      .toList();
  void init() {
    getApplicationDocumentsDirectory().then((value) {
      _dir = value;
      var list = value.list();
      list.forEach((element) {
        if (element.path.contains('.mp3')) {
          var path = element.path.split('.mp3')[0];
          final videoId = path.split('/').last;
          File file = File(path + '.json');
          final trackJson = file.readAsStringSync();
          _cache[videoId] = CacheEntry(videoId, path + '.mp3', trackJson);
        }
      });
    });
  }

  void setPlaying(String trackJson) {
    final file = File(_dir.path + '/now_playing.json');
    file.writeAsString(trackJson);
  }

  Future<void> set(
    String videoId,
    String trackJson,
  ) async {
    final audioFilePath = generatePath(videoId);
    _cache[videoId] = CacheEntry(videoId, audioFilePath, trackJson);
    File file = File(_dir.path + '/' + videoId + '.json');

    await file.writeAsString(trackJson);
  }

  String generatePath(String videoId) {
    final savePath = _dir.path + '/' + videoId + '.mp3';
    return savePath;
  }

  wrap(Function function) {
    return function;
  }
}

class CacheEntry {
  String videoId;
  String path;
  String trackJson;
  Duration get trackDuration {
    var jsonDecode2 = jsonDecode(trackJson);
    var duration = jsonDecode2['duration'];
    return Duration(seconds: duration);
  }

  CacheEntry(this.videoId, this.path, this.trackJson);
}
