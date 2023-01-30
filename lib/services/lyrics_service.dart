import 'package:dio/dio.dart';

class LyricsifyLyricsFinder extends LyricsFinder {
  var headers2 = {
    "accept":
        "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8",
    "accept-language": "tr-TR,tr;q=0.7",
    "cache-control": "max-age=0",
    "sec-ch-ua":
        "\"Not_A Brand\";v=\"99\", \"Brave\";v=\"109\", \"Chromium\";v=\"109\"",
    "sec-ch-ua-mobile": "?0",
    "sec-ch-ua-platform": "\"Windows\"",
    "sec-fetch-dest": "document",
    "sec-fetch-mode": "navigate",
    "sec-fetch-site": "none",
    "sec-fetch-user": "?1",
    "sec-gpc": "1",
    "upgrade-insecure-requests": "1"
  };

  @override
  String baseUrl = 'https://www.lyricsify.com/';
  @override
  Future<String> getLrc(String trackName, String artistName) async {
    client.options.headers = headers2;
    final query = '$trackName $artistName';
    final response = await client.get(baseUrl, queryParameters: {'q': query});
    if (response.statusCode != 200) {
      return '';
    }
    return getLrcFromHtml(response.data, artistName, trackName);
  }

  @override
  Future<String> getLyrics(String trackName, String artistName) {
    client.options.headers = headers2;
    final query = '$trackName $artistName';
    // TODO: implement getLyrics
    throw UnimplementedError();
  }

  Future<String> getLrcFromHtml(
      String html, String artistName, String trackName) async {
    client.options.headers = headers2;
    final res =
        [artistName, trackName].join(' ').replaceAll(' ', '-').toLowerCase();
    RegExp lrcRegex =
        RegExp(r'<a href="\/lyric\/(.*?)" class="title">(.*?)<\/a>');
    // RegExp downloadUrlRegex = RegExp(
    //     r'<a href="https:\/\/download\.lyricsify\.com\/(.*)\" rel="nofollow" target="_self');
    final regex = RegExp(r'\[([0-9]+):([0-9]+)\.([0-9]+)\](.*)<br>');
    final match = lrcRegex.allMatches(html);
    if (match.isEmpty) return '';
    final matched = match.where((element) =>
        element.group(2)!.toLowerCase().contains(artistName.toLowerCase()) &&
        element.group(2)!.toLowerCase().contains(trackName.toLowerCase()));
    // var futures = <Future<Response<String>>>[];
    // for (var i = 0; i < matches.length; i++) {
    //   final href = matches.elementAt(i).group(1);
    //   futures.add(client.get<String>(href!));
    // }
    if (matched.isEmpty) return '';

    final name = matched.first.group(2);
    final url = '${baseUrl}lyric/' + matched.first.group(1)!;
    final html2 = await client.get<String>(url);
    final f = regex.allMatches(html2.data!);
    // final downloadUrl = 'https://download.lyricsify.com/' +
    //     downloadUrlRegex.firstMatch(html2.data!)!.group(1)!;
    // client.options.headers['cookie'] =
    //     'lyricsifycom=ut30bsflp8rl6c10g9jd3mdv7l; amp_a0683b=oe96ou4czIpzIrzeh-241P.cmE4d3F4ZncxODRxMQ==..1gnver4o4.1gnvg3d6s.0.0.0';
    // client.options.headers['content-type'] = 'application/octet-stream';
    String lrc = f
        .map((e) => e.group(0)!.replaceAll('<br>', ''))
        .join('\n')
        .replaceAll('&#039;', "'");
    return lrc;
  }
}

abstract class LyricsFinder {
  final Dio client = Dio();
  String baseUrl = '';
  Future<String> getLrc(String trackName, String artistName);
  Future<String> getLyrics(String trackName, String artistName);
}
