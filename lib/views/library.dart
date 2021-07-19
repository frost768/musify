import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/components/albumlist_tile.dart';
import 'package:spotify_clone/components/playlist_tile.dart';
import 'package:spotify_clone/controllers/user_controller.dart';
import 'package:spotify_clone/data/albums.dart';
import 'package:spotify_clone/data/artists.dart';
import 'package:spotify_clone/data/playlists.dart';

class LibraryView extends StatelessWidget {
  LibraryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: UserController(),
      builder: (UserController user) => DefaultTabController(
        length: 3,
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: Text('Ara'),
                  expandedHeight: 200,
                  snap: true,
                  floating: true,
                  bottom: TabBar(
                      indicatorColor: Theme.of(context).accentColor,
                      tabs: [
                        Tab(
                          text: 'Çalma Listeleri',
                        ),
                        Tab(
                          text: 'Sanatçılar',
                        ),
                        Tab(
                          text: 'Albümler',
                        )
                      ]),
                ),
              ];
            },
            body: TabBarView(children: [
              ListView(children: [
                PlaylistTile(
                  'Çalma listesi oluştur',
                  isCreatePlaylist: true,
                  onTap: () => Get.toNamed('CreatePlaylistPage'),
                ),
                PlaylistTile(
                  'Beğenilen Şarkılar',
                  isFavoriteList: true,
                  subtitle: '${user.favorites.length} şarkı',
                  onTap: () => Get.toNamed('CreatePlaylistPage'),
                ),
                ...playlists
                    .map((p) => PlaylistTile(p.name,
                        subtitle:
                            'oluşturan ${p.createdBy?.name} ${p.createdAt?.toIso8601String()}'))
                    .toList()
              ]),
              ListView(
                  children: artists.map((e) => AlbumListTile(e.name)).toList()),
              ListView(
                children: albums.map((e) => PlaylistTile(e.name)).toList(),
              ),
            ])),
      ),
    );
  }
}
