import 'package:flutter/material.dart';
import 'package:spotify_clone/components/artist_circle_card.dart';
import 'package:spotify_clone/models/album.dart';
import 'package:spotify_clone/models/artist.dart';
import 'package:spotify_clone/views/views.dart';

class HomePageSliderCustomHeader extends StatelessWidget {
  Album? album;
  Artist? artist;
  HomePageSliderCustomHeader({Key? key, this.artist, this.album})
      : super(key: key);

  final TextStyle title = TextStyle(
      color: Colors.grey,
      fontSize: 10,
      fontWeight: FontWeight.bold,
      letterSpacing: 1);
  final TextStyle subtitle =
      TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    if (album != null)
      return Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 50,
            color: Colors.white,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                homePageCustomHeaderMoreLikeThis,
                style: title,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                album!.name,
                style: subtitle,
              )
            ],
          ),
        ],
      );
    else
      return Row(
        children: [
          Container(
              margin: const EdgeInsets.only(right: 10),
              width: 50,
              child: ArtistCircleCard(artist!, showName: false)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                homePageCustomHeaderForFans,
                style: title,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                artist!.name,
                style: subtitle,
              )
            ],
          )
        ],
      );
  }
}
