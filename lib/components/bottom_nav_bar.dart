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
              size: 30,
            )),
        BottomNavigationBarItem(
            label: 'Ara',
            icon: Icon(
              Icons.search,
              size: 30,
            )),
        BottomNavigationBarItem(
            label: 'Kitaplığın',
            icon: Icon(
              Icons.dehaze,
              size: 30,
            )),
      ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
            Colors.black,
            Colors.black87,
            Colors.black54,
            Colors.transparent
          ])),
      height: kBottomSideTotalHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          PlayerNarrow(),
          Divider(
            height: 2,
          ),
          BottomNavigationBar(
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
              onPageChange(value);
            },
            currentIndex: currentIndex,
            items: _icons,
            selectedLabelStyle: TextStyle(fontSize: 10),
            unselectedLabelStyle: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
