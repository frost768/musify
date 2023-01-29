import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/components/home_playlist_section.dart';
import 'package:spotify_clone/components/home_recommendations.dart';
import 'package:spotify_clone/core/consts.dart';
import 'package:spotify_clone/core/strings.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: CustomScrollView(slivers: [
        SliverAppBar(
          toolbarHeight: 100,
          floating: true,
          pinned: true,
          snap: false,
          title: Text(
            homeGreetingTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            Icon(Icons.notifications),
            Icon(Icons.settings),
            Icon(Icons.settings),
          ],
          bottom: AppBar(
              title: Row(
            children: [
              Text('Müzik'),
              SizedBox(width: 10),
              Text('data'),
            ],
          )),
        ),

        // SliverToBoxAdapter(child: HomePlaylistSection()),
        SliverToBoxAdapter(child: HomeRecommendations()),
        SliverToBoxAdapter(child: SizedBox(height: kBottomSideTotalHeight))
      ]),
    );
  }
}
