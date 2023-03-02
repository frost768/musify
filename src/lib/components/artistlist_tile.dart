import 'package:flutter/material.dart';
import 'package:spotify_clone/views/views.dart';

class ArtistListTile extends ListTile {
  final String name;

  final String artistPicUrl;

  ArtistListTile(this.name, this.artistPicUrl)
      : super(
          contentPadding: const EdgeInsets.all(10),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: Image.network(artistPicUrl).image,
          ),
          title: Text(
            name,
            style: kLibraryTabStyle,
          ),
        );
}
