import 'package:flutter/material.dart';
import 'package:spotify_clone/components/player_narrow.dart';
import 'package:spotify_clone/views/views.dart';

class BottomNavBar extends StatelessWidget {
  Function(int) onPageChange;
  BottomNavBar(this.onPageChange, {Key? key}) : super(key: key);
  get _icons => [
        IconButton(
            onPressed: () => onPageChange(0),
            icon: Icon(
              Icons.home,
            )),
        IconButton(
            onPressed: () => onPageChange(1),
            icon: Icon(
              Icons.search,
            )),
        IconButton(
            onPressed: () => onPageChange(2),
            icon: Icon(
              Icons.library_music_outlined,
            )),
      ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kBottomSideTotalHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          PlayerNarrow(),
          Divider(
            height: 2,
            color: kMainBackColor,
          ),
          BottomAppBar(
            color: kMainColor,
            child: SizedBox(
              height: kBottomSideItemHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _icons,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
