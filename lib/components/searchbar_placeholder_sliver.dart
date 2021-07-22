import 'package:flutter/material.dart';
import 'package:spotify_clone/components/searchbar_placeholder.dart';
import 'package:spotify_clone/core/consts.dart';

class SearchBarPlaceholderSliver extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: kMainBackColor, child: SearchBarPlaceholder());
  }

  @override
  double get maxExtent => 70.0;

  @override
  double get minExtent => 70.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
