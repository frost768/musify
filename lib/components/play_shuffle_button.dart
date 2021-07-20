import 'package:flutter/material.dart';
import 'package:spotify_clone/data/strings.dart';

class PlayShuffleButton extends StatelessWidget {
  PlayShuffleButton({
    Key? key,
  }) : super(key: key);

  final boxDecoration = BoxDecoration(
      color: Colors.green.shade800,
      borderRadius: BorderRadiusDirectional.all(Radius.circular(30)));
  final textStyle =
      TextStyle(letterSpacing: 1, fontSize: 15, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      decoration: boxDecoration,
      child: Center(
          child: Text(
        playShuffle,
        style: textStyle,
      )),
    );
  }
}
