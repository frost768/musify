import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/views/views.dart';

class LikedSongsSliver extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.purple, kMainBackColor])),
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
                  Text(likedSongsTitle,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                              .withOpacity(((shrinkOffset) / maxExtent)))),
                  IconButton(
                      onPressed: () => Get.back(), icon: Icon(Icons.more_vert)),
                ],
              ),
            ),
            Container(
              height: shrinkOffset <= 220 ? 220 - shrinkOffset : 0,
              child: Opacity(
                opacity: 1 - ((shrinkOffset) / maxExtent),
                child: Center(
                    child: Text(likedSongsTitle,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(
                                1 - ((shrinkOffset) / maxExtent))))),
              ),
            ),
            Container(
              width: 200,
              // height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.green.shade800,
                  borderRadius:
                      BorderRadiusDirectional.all(Radius.circular(30))),
              child: Center(
                  child: Text(
                'KARIŞIK ÇAL',
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
            )
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 354.0;

  @override
  double get minExtent => 132.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
