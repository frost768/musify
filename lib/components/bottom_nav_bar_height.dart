import 'package:flutter/material.dart';
import 'package:spotify_clone/core/consts.dart';

class BottomNavBarHeight extends StatelessWidget {
  const BottomNavBarHeight({Key? key}) : super(key: key);
  static const SliverToBoxAdapter sliver =
      SliverToBoxAdapter(child: BottomNavBarHeight());
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: kBottomSideTotalHeight + 10);
  }
}
