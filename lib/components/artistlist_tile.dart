import 'package:flutter/material.dart';
import 'package:spotify_clone/views/views.dart';

class ArtistListTile extends StatelessWidget {
  final String name;
  ArtistListTile(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            name,
            style: kLibraryTabStyle,
          ),
        ],
      ),
    );
  }
}
