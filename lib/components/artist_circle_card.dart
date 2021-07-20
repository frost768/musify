import 'package:flutter/material.dart';
import 'package:spotify_clone/core/consts.dart';
import 'package:spotify_clone/models/artist.dart';

class ArtistCircleCard extends StatelessWidget {
  final Artist artist;
  bool? showName;
  ArtistCircleCard(this.artist, {Key? key, this.showName = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        children: [
          Container(
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Colors.white,
            ),
          ),
          if (showName!)
            Container(
                margin: kMarginTop10,
                height: 40,
                child: Text(
                  artist.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
        ],
      ),
    );
  }
}
