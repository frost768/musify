import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/strings.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/providers/player_provider.dart';
import 'package:spotify_clone/providers/playlist_provider.dart';
import 'package:spotify_clone/views/player_full.dart';

class PlayerScroller extends ConsumerStatefulWidget {
  final bool isNarrow;
  const PlayerScroller({this.isNarrow = false, key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlayerScrollerState();
}

class _PlayerScrollerState extends ConsumerState<PlayerScroller> {
  PageRouteBuilder downToUpTranstition(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  final TextStyle kSongNameStyle =
      const TextStyle(fontSize: 13, fontWeight: FontWeight.bold);
  final TextStyle kArtistStyle =
      const TextStyle(fontSize: 13, color: Colors.grey);
  @override
  Widget build(BuildContext context) {
    print('PlayerScroller');
    var currIndex = ref.watch(indexProvider);
    final _controller = PageController(initialPage: currIndex);
    final playerState = ref.watch(playerStateProvider);
    var player = ref.watch(playerStateProvider.notifier);
    final playlist = ref.watch(playListProvider);
    return PageView.builder(
      controller: _controller,
      onPageChanged: (index) {
        var i = index % playlist.length;
        if (i > ref.read(indexProvider)) {
          player.next();
        } else {
          player.previous();
        }
      },
      itemCount: playerState.repeatEnabled ? null : playlist.length,
      itemBuilder: (context, index) {
        if (widget.isNarrow) {
          return _narrow(context, playlist, index);
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Image.network(
            playlist[index % playlist.length].album.coverXl,
          ),
        );
      },
    );
  }

  GestureDetector _narrow(
      BuildContext context, List<Track> playlist, int index) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).push(downToUpTranstition(PlayerFull())),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 160,
              child: Text(
                playlist[index].title,
                style: kSongNameStyle.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              playlist[index].artist.name,
              style: kArtistStyle,
              overflow: TextOverflow.ellipsis,
            ),
            Offstage(
              child: Text(
                playerNarrowAvaiableDevices,
                style: kSongNameStyle,
              ),
            )
          ]),
    );
  }
}
