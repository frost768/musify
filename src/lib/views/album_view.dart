import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/components/artistlist_tile.dart';
import 'package:spotify_clone/components/bottom_nav_bar.dart';
import 'package:spotify_clone/components/bottom_nav_bar_height.dart';
import 'package:spotify_clone/components/home_horizontal_slider.dart';
import 'package:spotify_clone/components/track_tile.dart';
import 'package:spotify_clone/models/models.dart';
import 'package:spotify_clone/providers/player_provider.dart';
import 'package:spotify_clone/providers/playlist_provider.dart';
import 'package:spotify_clone/views/views.dart';

class AlbumView extends StatefulWidget {
  int? albumId;

  AlbumView({this.albumId, Key? key}) : super(key: key);

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      setState(() {});
    });
  }

  // String get albumTrackAndDurationInfo =>
  final albumNameStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  final boxDecoration = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.grey, kMainBackColor]));

  final albumArtNameStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 25);

  final albumArtSubtitleStyle =
      TextStyle(color: Colors.grey, fontWeight: FontWeight.w500);

  final albumTrackAndDurationInfoStyle = TextStyle(color: Colors.white);

  final youMayAlsoLikeTheseStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  final copyrightTextStyle = TextStyle(fontSize: 15);

  final copyrightTextMargin =
      const EdgeInsets.only(left: 10, top: 40, bottom: 20);

  final albumArtSubtitleMargin = const EdgeInsets.only(bottom: 10);

  final albumArtMargin =
      const EdgeInsets.only(left: 50, right: 50, top: 50, bottom: 10);

  late ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return ref.watch(albumDetailsProvider.call(widget.albumId!)).when(
              data: (albumDetail) => Scaffold(
                extendBody: true,
                bottomNavigationBar: BottomNavBar(),
                body: Stack(
                  children: [
                    // Container(
                    //   decoration: BoxDecoration(
                    //       gradient: LinearGradient(
                    //           begin: Alignment.topCenter,
                    //           end: Alignment.bottomCenter,
                    //           stops: [0.5, 1],
                    //           colors: [Colors.purple, Colors.transparent])),
                    // ),
                    CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverAppBar(
                            expandedHeight: 270,
                            pinned: true,
                            stretch: true,
                            flexibleSpace: FlexibleSpaceBar(
                              stretchModes: [StretchMode.zoomBackground],
                              background: Image.network(
                                albumDetail.coverBig,
                              ),
                            )),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          sliver: SliverToBoxAdapter(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(albumDetail.title,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 10,
                                    foregroundImage: Image.network(
                                            albumDetail.artist.picture)
                                        .image,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    albumDetail.artist.name,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  )
                                ],
                              ),
                              Text(resolveType(albumDetail.type) +
                                  ' - ' +
                                  albumDetail.releaseDate.year.toString())
                            ],
                          )),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.only(right: 15),
                          sliver: SliverToBoxAdapter(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.favorite)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.more_vert)),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 60.0),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.shuffle)),
                                )
                              ],
                            ),
                          ),
                        ),
                        SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                            return AlbumTrackTile(
                              albumDetail,
                              albumDetail.trackList[index],
                            );
                          }, childCount: albumDetail.nbTracks),
                        ),
                        SliverToBoxAdapter(
                          child: ListTile(
                              title: Text(albumDetail.releaseDate.ddMonthYYYY)),
                        ),
                        SliverToBoxAdapter(
                          child: ArtistListTile(albumDetail.artist.name,
                              albumDetail.artist.picture),
                        ),
                        SliverToBoxAdapter(child: HomeHorizontalSlider()),
                        SliverToBoxAdapter(
                          child: Row(
                            children: [
                              Container(
                                  margin: copyrightTextMargin,
                                  child: Text(
                                    '${albumDetail.label}',
                                    style: copyrightTextStyle,
                                  )),
                            ],
                          ),
                        ),
                        BottomNavBarHeight.sliver
                      ],
                    ),
                    _Fab(albumDetail, _scrollController)
                  ],
                ),
              ),
              loading: () => Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (Object error, StackTrace stackTrace) => Scaffold(
                body: Center(
                  child: Icon(Icons.dangerous),
                ),
              ),
            );
      },
    );
    // return Scaffold(
    //   appBar: _appBar,
    //   bottomNavigationBar: BottomNavBar(),
    //   body: SingleChildScrollView(
    //       child: Column(
    //     children: [
    //       Container(
    //           margin: albumArtMargin,
    //           height: 170,
    //           width: 170,
    //           color: Colors.white),
    //       Container(
    //         margin: const EdgeInsets.all(10),
    //         child: Text(
    //           album!.title,
    //           style: albumArtNameStyle,
    //         ),
    //       ),
    //       Container(
    //         margin: albumArtSubtitleMargin,
    //         height: 20,
    //         child: Text(
    //           'd',
    //           // 'Albüm / ${album!.artist.name} • ${album!.createdAt!.year}',
    //           style: albumArtSubtitleStyle,
    //         ),
    //       ),
    //       PlayShuffleButton(),
    //       // ...album!.tracks.map((track) => TrackTile(track)).toList(),
    //       // ListTile(
    //       //   title: Text(
    //       //     '${album!.createdAt!.ddMonthYYYY}',
    //       //   ),
    //       //   subtitle: Text(
    //       //     albumTrackAndDurationInfo,
    //       //     style: albumTrackAndDurationInfoStyle,
    //       //   ),
    //       // ),
    //       // ListTile(
    //       //   leading: CircleAvatar(
    //       //     radius: 25,
    //       //     backgroundColor: Colors.white,
    //       //   ),
    //       //   title: Text(
    //       //     '${album!.artist.name}',
    //       //   ),
    //       // ),
    //       Container(
    //         margin: const EdgeInsets.only(left: 10),
    //         child: HomeHorizontalSlider(
    //             header: Center(
    //           child: Text(
    //             albumViewYouMayAlsoLikeThese,
    //             style: youMayAlsoLikeTheseStyle,
    //           ),
    //         )),
    //       ),
    //       // Row(
    //       //   children: [
    //       //     Container(
    //       //         margin: copyrightTextMargin,
    //       //         child: Text(
    //       //           '${album!.copyrightText}',
    //       //           style: copyrightTextStyle,
    //       //         )),
    //       //   ],
    //       // )
    //     ],
    //   )),
    // );
//   }

//   Positioned _buildFab(WidgetRef ref, AlbumDetail albumDetail) {
//     final double defaultMargin = 380;
//     double top = defaultMargin;
//     if (_scrollController.hasClients) {
//       top = defaultMargin - _scrollController.offset;
//       if (_scrollController.offset > 330) {
//         top = 50;
//       }
//     }
//     var bool = ref.watch(currentTrackProvider) == null ||
//         ref.watch(currentTrackProvider)!.album.id != albumDetail.id;
//     var icon = Icon(bool ? Icons.pause : Icons.play_arrow);
//     return Positioned(
//         top: top,
//         right: 16,
//         child: FloatingActionButton(
//           child: icon,
//           onPressed: () {
//             if (bool) {
//               ref
//                   .read(playerStateProvider.notifier)
//                   .play(albumDetail: albumDetail, source: PlayerSource.album);
//               return;
//             } else if (ref.read(playerStateProvider).isPlaying) {
//               ref.read(playerStateProvider.notifier).pause();
//             } else {
//               ref.read(playerStateProvider.notifier).resume();
//             }
//           },
//         ));
  }
}

class _Fab extends ConsumerStatefulWidget {
  AlbumDetail albumDetail;

  ScrollController scrollController;

  _Fab(this.albumDetail, this.scrollController, {Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __FabState();
}

class __FabState extends ConsumerState<_Fab> {
  final double defaultMargin = 380;

  @override
  Widget build(BuildContext context) {
    double top = defaultMargin;
    if (widget.scrollController.hasClients) {
      top = defaultMargin - widget.scrollController.offset;
      if (widget.scrollController.offset > 330) {
        top = 50;
      }
    }
    var bool = ref.watch(currentTrackProvider) == null ||
        ref.watch(currentTrackProvider)!.album.id != widget.albumDetail.id;
    var icon = Icon(bool ? Icons.play_arrow : Icons.pause);
    return Positioned(
        top: top,
        right: 16,
        child: FloatingActionButton(
          child: icon,
          onPressed: () {
            if (bool) {
              ref.read(playerStateProvider.notifier).play(
                  albumDetail: widget.albumDetail, source: PlayerSource.album);
            } else if (ref.read(playerStateProvider).isPlaying) {
              ref.read(playerStateProvider.notifier).pause();
            } else {
              ref.read(playerStateProvider.notifier).resume();
            }
          },
        ));
  }
}
