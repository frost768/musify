import 'package:flutter/material.dart';
import 'package:spotify_clone/components/home_horizontal_slider.dart';
import 'package:spotify_clone/components/home_page_slider_custom_header.dart';
import 'package:spotify_clone/core/consts.dart';
import 'package:spotify_clone/data/albums.dart';
import 'package:spotify_clone/data/artists.dart';
import 'package:spotify_clone/views/views.dart';

class HomeRecommendations extends StatelessWidget {
  const HomeRecommendations({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: kMarginLeft10,
      child: Column(
        children: [
          HomeHorizontalSlider(
              header: HomePageSliderCustomHeader(
            artist: eminem,
          )),
          HomeHorizontalSlider(
              header: Text(
            homeUniqueSelections,
            style: kHeadingTitle,
          )),
          HomeHorizontalSlider(
              header: HomePageSliderCustomHeader(
            album: kamikaze,
          )),
          HomeHorizontalSlider(
              header: Text(
            homeRecentlyPlayed,
            style: kHeadingTitle,
          )),
          HomeHorizontalSlider(
              header: Text(
            homeListenAgain,
            style: kHeadingTitle,
          )),
        ],
      ),
    );
  }
}
