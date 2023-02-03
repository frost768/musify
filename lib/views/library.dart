import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spotify_clone/components/bottom_nav_bar_height.dart';
import 'package:spotify_clone/components/filter_chips.dart';
import 'package:spotify_clone/components/playlist_tile.dart';
import 'package:spotify_clone/components/track_tile.dart';
import 'package:spotify_clone/core/app.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/services/cache_service.dart';
import 'package:spotify_clone/views/views.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          toolbarHeight: 90,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: Icon(Icons.add)),
            IconButton(
                onPressed: CacheService().clear, icon: Icon(Icons.delete)),
          ],
          title: Row(
            children: [
              CircleAvatar(radius: 15, backgroundColor: Colors.white),
              SizedBox(width: 10),
              Text(libraryHeaderMusic),
            ],
          ),
        ),
        SliverToBoxAdapter(child: LibraryPageFilterChips()),
        SliverPadding(
          padding: const EdgeInsets.only(left: 0),
          sliver: SliverList(
              delegate: SliverChildListDelegate([
            OrderAndViewOptions(),
            PlaylistTile(
              libraryListTileLikedSongs,
              isFavoriteList: true,
              // TODO: will add user data and read from there
              subtitle: '0 şarkı',
              onTap: () => onPageChange(4),
            ),
            ...CacheService()
                .trackList
                .map((e) => Track.fromMap(jsonDecode(e)))
                .map((e) => TrackTile(e))
                .toList(),
            PlaylistTile(
              libraryListTileAddArtist,
              isAdd: true,
              // onTap: () => Get.toNamed('CreatePlaylist'),
            ),
            PlaylistTile(
              libraryListTileAddPodcastAndPrograms,
              isAdd: true,
              // onTap: () => Get.toNamed('CreatePlaylist'),
            ),
            BottomNavBarHeight()
          ])),
        ),
      ],
    );
  }
}

class OrderAndViewOptions extends StatefulWidget {
  const OrderAndViewOptions({key});

  @override
  State<OrderAndViewOptions> createState() => _OrderAndViewOptionsState();
}

class _OrderAndViewOptionsState extends State<OrderAndViewOptions> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text('Son çalınanlar'),
          ),
          SizedBox(width: 10),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.grid_view), iconSize: 20)
        ],
      ),
    );
  }
}
