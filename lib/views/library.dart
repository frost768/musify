import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/components/playlist_tile.dart';
import 'package:spotify_clone/components/track_tile.dart';
import 'package:spotify_clone/controllers/user_controller.dart';
import 'package:spotify_clone/core/app.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/services/cache_service.dart';
import 'package:spotify_clone/views/views.dart';

class LibraryView extends StatelessWidget {
  LibraryView({Key? key}) : super(key: key);
  List<String> _filterList = [
    'Çalma listeleri',
    "Podcast'ler ve Programlar",
    'Albümler',
    'Sanatçılar',
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: UserController(),
        builder: (UserController user) => CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  toolbarHeight: 80,
                  actions: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                  ],
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        libraryHeaderMusic,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 50,
                    child: ListView.separated(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => SizedBox(width: 10),
                      itemBuilder: (context, index) => Chip(
                        label: Text(_filterList[index]),
                      ),
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  OrderAndViewOptions(),
                  PlaylistTile(
                    libraryListTileLikedSongs,
                    isFavoriteList: true,
                    subtitle: '${user.favorites.length} şarkı',
                    onTap: () => onPageChange(4),
                  ),
                  ...CacheService.trackList
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
                ])),
              ],
            ));
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
