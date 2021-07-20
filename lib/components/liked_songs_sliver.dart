import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/components/play_shuffle_button.dart';
import 'package:spotify_clone/views/views.dart';

class LikedSongsSliver extends SliverPersistentHeaderDelegate {
  final boxDecoration = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.purple, kMainBackColor]));
  TextStyle titleStyle(size, shrinkOffset) => TextStyle(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: Colors.white.withOpacity(opacityRatio(shrinkOffset)));
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: boxDecoration,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.arrow_back)),
                  Text(likedSongsTitle, style: titleStyle(15, shrinkOffset)),
                  IconButton(
                      onPressed: () => Get.back(), icon: Icon(Icons.more_vert)),
                ],
              ),
            ),
            Container(
              height: titleHeight(shrinkOffset),
              child: Opacity(
                opacity: opacity(shrinkOffset),
                child: Center(
                    child: Text(likedSongsTitle,
                        style: titleStyle(30, shrinkOffset))),
              ),
            ),
            PlayShuffleButton()
          ],
        ),
      ),
    );
  }

  double titleHeight(double shrinkOffset) =>
      shrinkOffset <= 220 ? 220 - shrinkOffset : 0;

  double opacityRatio(double shrinkOffset) => ((shrinkOffset) / maxExtent);

  double opacity(double shrinkOffset) => 1 - opacityRatio(shrinkOffset);

  @override
  double get maxExtent => 354.0;

  @override
  double get minExtent => 132.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
