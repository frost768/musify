import 'package:flutter/material.dart';
import 'package:spotify_clone/components/home_horizontal_slider.dart';
import 'package:spotify_clone/components/home_page_slider_custom_header.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/services/cache_service.dart';
import 'package:spotify_clone/views/views.dart';

class HomeRecommendations extends StatelessWidget {
  const HomeRecommendations({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // HomeHorizontalSlider(
        //     header: HomePageSliderCustomHeader(
        //   artist: eminem,
        // )),
        HomeHorizontalSlider(
            header: Text(
          homeUniqueSelections,
          style: Theme.of(context).textTheme.titleLarge,
        )),
        // HomeHorizontalSlider(
        //     header: HomePageSliderCustomHeader(
        //   artist: (Track.fromJson(CacheService().trackList.first)).artist,
        // )),
        HomeHorizontalSlider(
            header: Text(
          homeRecentlyPlayed,
          style: Theme.of(context).textTheme.titleLarge,
        )),
        HomeHorizontalSlider(
            header: Text(
          homeListenAgain,
          style: Theme.of(context).textTheme.titleLarge,
        )),
      ],
    );
  }
}
