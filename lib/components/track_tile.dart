import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/components/explicit_widget.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/providers/player_provider.dart';
import 'package:spotify_clone/providers/playlist_provider.dart';

class TrackTile extends ConsumerWidget {
  final textStyle = TextStyle(fontSize: 12, color: Colors.grey);
  final Track track;
  TrackTile(this.track, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentTrack = ref.watch(currentTrackProvider);
    var isPlaying =
        (currentTrack == null) ? false : currentTrack.id == track.id;
    return ListTile(
      onTap: () => ref.read(playerStateProvider.notifier).play(track: track),
      leading: SizedBox(
        width: 60,
        height: 60,
        child: Image.network(track.album.coverBig),
      ),
      title: title(isPlaying, context),
      subtitle: Row(
        children: [
          if (track.explicitLyrics) ExplicitWidget(),
          Text(
            track.artist.name,
            style: textStyle,
          ),
        ],
      ),
      trailing: IconButton(
          onPressed: () {
            showBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    Text(track.title),
                    Text(track.artist.name),
                    ListTile(
                      title: Text('Sıraya ekle'),
                      onTap: () {
                        ref
                            .watch(playListProvider.notifier)
                            .addToPlaylist(track);
                        Navigator.of(context).pop();
                      },
                    )
                  ]),
                );
              },
            );
          },
          icon: Icon(
            Icons.more_vert_outlined,
            color: Colors.grey,
          )),
    );
  }

  Widget title(bool isPlaying, BuildContext context) {
    if (isPlaying) {
      return Row(
        children: [
          Icon(
            Icons.equalizer,
            size: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2 - 5,
            margin: const EdgeInsets.only(left: 5),
            child: Text(
              track.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.green),
            ),
          )
        ],
      );
    } else {
      return Text(
        track.title,
        overflow: TextOverflow.ellipsis,
      );
    }
  }
}
