import 'package:flutter/material.dart';
import 'package:spotify_clone/views/views.dart';

class HomePlaylistSection extends StatelessWidget {
  final backgroundGradient = BoxDecoration(
      gradient: RadialGradient(
    center: Alignment.topLeft,
    radius: 1.8,
    stops: [0, 0.3],
    colors: [Colors.white10, kMainBackColor],
  ));
  final playlistAlbumArtLeading = BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
      color: Colors.white);
  HomePlaylistSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        shrinkWrap: true,
        childAspectRatio: 3 / 1,
        crossAxisCount: 2,
        physics: NeverScrollableScrollPhysics(),
        children: []
        // TODO: will be fetched from user data
        );
  }
}
