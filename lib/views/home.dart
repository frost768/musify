import 'package:flutter/material.dart';
import 'package:spotify_clone/components/home_playlist_section.dart';
import 'package:spotify_clone/components/home_recommendations.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        HomePlaylistSection(),
        HomeRecommendations(),
      ]),
    );
  }
}
