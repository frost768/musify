import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/strings.dart';
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

  @override
  Widget build(BuildContext context) {
    print('PlayerScroller');
    final _controller = PageController(initialPage: ref.watch(indexProvider));
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
          return GestureDetector(
            onTap: () =>
                Navigator.of(context).push(downToUpTranstition(PlayerFull())),
            child: _CurrentTrackInfo(),
          );
        }
        print(index);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Image.network(
            ref
                .watch(playListProvider)[
                    index % ref.watch(playListProvider).length]
                .album
                .coverXl,
          ),
        );
      },
    );
  }
}

class _CurrentTrackInfo extends ConsumerWidget {
  final TextStyle kSongNameStyle = const TextStyle(
      color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold);
  final TextStyle kArtistStyle =
      const TextStyle(fontSize: 13, color: Colors.grey);
  const _CurrentTrackInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var playList = ref.watch(playListProvider);
    var index = ref.watch(indexProvider);
    if (playList.isEmpty) return Container();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160,
          child: Text(
            playList[index % playList.length].title,
            style: kSongNameStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          playList[index % playList.length].artist.name,
          style: kArtistStyle,
          overflow: TextOverflow.ellipsis,
        ),
        Offstage(
          child: Text(
            playerNarrowAvaiableDevices,
            style: kSongNameStyle,
          ),
        )
      ],
    );
  }
}

class AlbumArtNarrowPlayer extends ConsumerWidget {
  const AlbumArtNarrowPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 40,
      width: 40,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image:
                Image.network(ref.watch(currentTrackProvider)!.album.coverBig)
                    .image),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
