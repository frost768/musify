import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/components/explicit_widget.dart';
import 'package:spotify_clone/models/models.dart';
import 'package:spotify_clone/providers/player_provider.dart';
import 'package:spotify_clone/providers/playlist_provider.dart';

class TrackTile extends ConsumerStatefulWidget {
  final Track track;
  AlbumDetail? albumDetail;
  List<Track>? playlist;
  final bool showAlbumCover;
  PlayerSource source;

  TrackTile(this.track,
      {this.albumDetail,
      this.playlist,
      this.source = PlayerSource.track,
      this.showAlbumCover = true,
      Key? key})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TrackTileState();
}

class _TrackTileState extends ConsumerState<TrackTile> {
  final textStyle = const TextStyle(fontSize: 12, color: Colors.grey);
  @override
  Widget build(BuildContext context) {
    var currentTrack = ref.watch(currentTrackProvider);
    var isPlaying =
        (currentTrack == null) ? false : currentTrack.id == widget.track.id;
    return ListTile(
      onTap: () => ref.read(playerStateProvider.notifier).play(
          track: widget.track,
          source: widget.source,
          albumDetail: widget.albumDetail,
          playlist: widget.playlist),
      leading: _buildLeading(),
      title: _buildTitle(isPlaying, context),
      subtitle: Row(
        children: [
          if (widget.track.explicitLyrics) ExplicitWidget(),
          Text(
            widget.track.artist.name,
            style: textStyle,
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {
                widget.track.liked = !widget.track.liked;
                setState(() {});
              },
              icon: Icon(
                widget.track.liked ? Icons.favorite : Icons.favorite_outline,
                size: 20,
                color: widget.track.liked ? Colors.green : Colors.white,
              )),
          IconButton(
              onPressed: () {
                showBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(children: [
                        Text(widget.track.title),
                        Text(widget.track.artist.name),
                        ListTile(
                          title: Text('Sıraya ekle'),
                          onTap: () {
                            ref
                                .watch(playListProvider.notifier)
                                .addToPlaylist(widget.track);
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
        ],
      ),
    );
  }

  SizedBox? _buildLeading() {
    return !widget.showAlbumCover
        ? null
        : SizedBox(
            width: 60,
            height: 60,
            child: Image.network(widget.track.album.coverBig),
          );
  }

  Widget _buildTitle(bool isPlaying, BuildContext context) {
    if (isPlaying) {
      return Row(
        children: [
          Icon(
            Icons.equalizer,
            size: 20,
            color: Theme.of(context).primaryColor,
          ),
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: Text(
              widget.track.title,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
          )
        ],
      );
    } else {
      return Text(
        widget.track.title,
        overflow: TextOverflow.ellipsis,
      );
    }
  }
}

class AlbumTrackTile extends TrackTile {
  AlbumTrackTile(AlbumDetail albumDetail, Track track)
      : super(track,
            albumDetail: albumDetail,
            source: PlayerSource.album,
            showAlbumCover: false);
}

class PlaylistTrackTile extends TrackTile {
  PlaylistTrackTile(List<Track> playlist, Track track)
      : super(track,
            playlist: playlist,
            source: PlayerSource.playlist,
            showAlbumCover: false);
}
