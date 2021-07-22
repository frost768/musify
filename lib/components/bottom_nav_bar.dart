import 'package:flutter/material.dart';
import 'package:spotify_clone/components/player_narrow.dart';
import 'package:spotify_clone/core/app.dart';
import 'package:spotify_clone/views/views.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  get _icons => [
        BottomNavigationBarItem(
            label: 'Ana Sayfa',
            icon: Icon(
              Icons.home,
            )),
        BottomNavigationBarItem(
            label: 'Ara',
            icon: Icon(
              Icons.search,
            )),
        BottomNavigationBarItem(label: 'Kitaplığın', icon: Icon(Icons.dehaze)),
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
          BottomNavigationBar(
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
              onPageChange(value);
            },
            selectedItemColor: Colors.white,
            currentIndex: currentIndex,
            items: _icons,
          ),
        ],
      ),
    );
  }
}
