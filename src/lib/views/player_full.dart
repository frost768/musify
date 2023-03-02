import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:flutter_lyric/lyrics_reader_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/components/player_scroller.dart';
import 'package:spotify_clone/providers/player_provider.dart';
import 'package:spotify_clone/providers/playlist_provider.dart';

import 'package:spotify_clone/views/views.dart';

class PlayerFull extends StatelessWidget {
  PlayerFull({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const PlayerFullAppBar(),
              Container(
                height: MediaQuery.of(context).size.height / 1.8,
                child: const PlayerScroller(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: const PlayerControls(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: LyricsCard(),
              )
            ],
          ),
        ),
      ],
    ));
  }
}

class PlayerFullAppBar extends ConsumerWidget {
  const PlayerFullAppBar({Key? key}) : super(key: key);

  final kHeaderTitleStyle = const TextStyle(fontSize: 10, letterSpacing: 1);
  final kAlbumNameStyle =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTrack = ref.watch(currentTrackProvider);
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.expand_more),
        onPressed: Navigator.of(context).pop,
      ),
      centerTitle: true,
      title: Column(
        children: [
          Text(
            'ALBÜMDEN ÇALINIYOR',
            style: kHeaderTitleStyle,
          ),
          Text(
            currentTrack!.album.title,
            style: kAlbumNameStyle,
          )
        ],
      ),
      actions: [IconButton(icon: Icon(Icons.more_vert), onPressed: () => {})],
    );
  }
}

class PlayerControls extends StatelessWidget {
  const PlayerControls({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('PlayerControls');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          const _CurrentTrackInfoFull(),
          SizedBox(height: 20),
          const _PlayerSeekBar(),
          SizedBox(height: 20),
          const _PlayerDurationRow(),
          const _PlayerControls(),
          const _DevicesAndPlaylistRow()
        ],
      ),
    );
  }
}

class _PlayerDurationRow extends ConsumerWidget {
  const _PlayerDurationRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<Duration?>(
              initialData: ref.read(playerStateProvider).position,
              stream: ref.read(audioPlayerProvider).onPositionChanged,
              builder: (context, snapshot) {
                return Text(snapshot.data!.trackTime,
                    style: kPlayerTimeStringStyle);
              }),
          Text(ref.read(currentTrackProvider)!.pDuration.trackTime,
              style: kPlayerTimeStringStyle),
        ],
      ),
    );
  }
}

class _DevicesAndPlaylistRow extends StatelessWidget {
  const _DevicesAndPlaylistRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          iconSize: 20,
          onPressed: () {},
          icon: Icon(Icons.tv),
        ),
        IconButton(
          iconSize: 20,
          icon: Icon(Icons.playlist_play),
          onPressed: () {
            // TODO: add reorderable playlist bottomsheet
          },
        )
      ],
    );
  }
}

class _PlayerControls extends ConsumerWidget {
  const _PlayerControls();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerStateProvider);
    final player = ref.watch(playerStateProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          iconSize: 30,
          onPressed: player.toggleShuffle,
          icon: Icon(Icons.shuffle),
        ),
        IconButton(
            iconSize: 50,
            onPressed: player.previous,
            icon: Icon(Icons.skip_previous)),
        _PlayerFullPlayButton(player: player, playerState: playerState),
        IconButton(
            iconSize: 50, onPressed: player.next, icon: Icon(Icons.skip_next)),
        IconButton(
          iconSize: 30,
          onPressed: player.toggleRepetition,
          icon: playerState.repeatEnabled
              ? Icon(Icons.repeat, color: Colors.green)
              : Icon(Icons.repeat),
        )
      ],
    );
  }
}

class _PlayerFullPlayButton extends StatelessWidget {
  const _PlayerFullPlayButton({
    Key? key,
    required this.player,
    required this.playerState,
  }) : super(key: key);

  final PlayerNotifier player;
  final Player playerState;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.inverseSurface),
      child: IconButton(
          iconSize: 50,
          onPressed: player.togglePlay,
          icon: Icon(playerState.isPlaying ? Icons.pause : Icons.play_arrow),
          color: Theme.of(context).colorScheme.surface),
    );
  }
}

class _CurrentTrackInfoFull extends ConsumerWidget {
  const _CurrentTrackInfoFull();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('_CurrentTrackInfoFull');
    final currentTrack = ref.watch(currentTrackProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              child: Text(
                currentTrack!.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              currentTrack.artist.name,
              style: TextStyle(fontSize: 15, color: Colors.grey),
            )
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
              currentTrack.liked ? Icons.favorite : Icons.favorite_outline,
              color: currentTrack.liked ? Colors.green : Colors.white),
        ),
      ],
    );
  }
}

class _PlayerSeekBar extends ConsumerWidget {
  const _PlayerSeekBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('_PlayerSeekBar');
    final currentTrack = ref.read(currentTrackProvider);
    return StreamBuilder<Duration?>(
      initialData: ref.read(playerStateProvider).position,
      stream: ref.read(audioPlayerProvider).onPositionChanged,
      builder: (context, snapshot) {
        return Slider(
            value: snapshot.data!.inSeconds.toDouble(),
            max: currentTrack!.pDuration.inSeconds.toDouble(),
            onChangeEnd: (value) => ref
                .read(audioPlayerProvider)
                .seek(Duration(seconds: value.toInt())),
            onChanged: (double value) => 0);
      },
    );
  }
}

class LyricsCard extends ConsumerWidget {
  LyricsCard({key});

  final lyricUI = LyUI();

  LyricsReaderModel _getLyricModel(String lrc) =>
      LyricsModelBuilder.create().bindLyricToMain(lrc).getModel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('LyricsCard');
    return ref
        .watch(lyricsProvider.call(ref.watch(currentTrackProvider)!))
        .maybeWhen(
          orElse: () => Container(),
          data: (data) => data.isEmpty
              ? Container()
              : Container(
                  margin: const EdgeInsets.only(
                      left: 5, right: 5, top: 5, bottom: 30),
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  height: 370,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Şarkı Sözleri',
                                style: Theme.of(context).textTheme.button),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.fullscreen_rounded))
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 10,
                          child: StreamBuilder<Duration?>(
                              stream: ref
                                  .read(audioPlayerProvider)
                                  .onPositionChanged,
                              builder: (context, snapshot) {
                                return LyricsReader(
                                  model: !snapshot.hasData
                                      ? _getLyricModel('')
                                      : _getLyricModel(data),
                                  position: !snapshot.hasData
                                      ? 0
                                      : snapshot.data!.inMilliseconds,
                                  lyricUi: lyricUI,
                                  playing:
                                      ref.read(playerStateProvider).isPlaying,
                                  size: Size(double.infinity,
                                      MediaQuery.of(context).size.height / 2),
                                  emptyBuilder: () => Center(
                                    child: Text(
                                      'No lyrics',
                                      style: lyricUI.getOtherMainTextStyle(),
                                    ),
                                  ),
                                );
                              })),
                      ActionChip(
                          onPressed: () {},
                          visualDensity: VisualDensity(vertical: -2),
                          backgroundColor: Colors.red,
                          avatar: Icon(
                            Icons.share,
                            size: 15,
                          ),
                          label: Text('PAYLAŞ'))
                    ],
                  ),
                ),
        );
  }
}
