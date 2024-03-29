import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/components/player_scroller.dart';
import 'package:spotify_clone/providers/player_provider.dart';
import 'package:spotify_clone/providers/playlist_provider.dart';
import 'package:spotify_clone/views/views.dart';

class PlayerNarrow extends ConsumerWidget {
  PlayerNarrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('PlayerNarrow');
    final currentTrack = ref.watch(currentTrackProvider);
    final player = ref.watch(playerStateProvider.notifier);
    final playerState = ref.watch(playerStateProvider);
    print(currentTrack);
    if (currentTrack == null) return Container();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: kPlayerNarrowHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const _AlbumArtNarrowPlayer(),
                Expanded(flex: 2, child: PlayerScroller(isNarrow: true)),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          currentTrack.liked
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          // color:
                          //     currentTrack.liked ? Colors.green : Colors.white,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          player.togglePlay();
                        },
                        icon: Icon(
                          playerState.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const _PlayerNarrowBar()
        ],
      ),
    );
  }
}

class _PlayerNarrowBar extends ConsumerWidget {
  const _PlayerNarrowBar();
  final boxDecoration = const BoxDecoration(
      gradient: LinearGradient(colors: [Colors.purple, Colors.pink]));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<Duration?>(
        stream: ref.read(audioPlayerProvider).onPositionChanged,
        builder: (context, snapshot) {
          return Container(
            decoration: boxDecoration,
            height: 1,
            width: !snapshot.hasData
                ? 0
                : snapshot.data!.inSeconds *
                    (MediaQuery.of(context).size.width /
                        ref.watch(currentTrackProvider)!.pDuration.inSeconds),
          );
        });
  }
}

class _AlbumArtNarrowPlayer extends ConsumerWidget {
  const _AlbumArtNarrowPlayer({Key? key}) : super(key: key);

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
