// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:spotify_clone/components/liked_songs_sliver.dart';
// import 'package:spotify_clone/components/track_tile.dart';
// import 'package:spotify_clone/controllers/user_controller.dart';

// class LikedSongs extends StatelessWidget {
//   LikedSongs({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(slivers: [
//       SliverPersistentHeader(pinned: true, delegate: LikedSongsSliver()),
//       GetBuilder(
//         init: UserController(),
//         builder: (UserController user) => SliverList(
//             delegate: SliverChildListDelegate(
//                 user.favorites.map((e) => TrackTile(e)).toList())),
//       )
//     ]);
//   }
// }
