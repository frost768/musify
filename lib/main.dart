import 'package:flutter/material.dart';
import 'package:spotify_clone/components/player_narrow.dart';
import 'package:spotify_clone/data/playlists.dart';
import 'package:spotify_clone/views/views.dart';

void main() => runApp(MyApp());

final List<Widget> _pages = [HomeView(), SearchView(), LibraryView()];

class MyApp extends StatelessWidget {
  final PageController _pageController = PageController();
  void onPageChange(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: kMainColor),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        backgroundColor: kMainBackColor,
        body: PageView(
          children: _pages,
          controller: _pageController,
          onPageChanged: onPageChange,
        ),
        bottomNavigationBar: _buildBottomBar,
      ),
    );
  }

  Widget get _buildBottomBar {
    var _icons = [
      IconButton(
          onPressed: () => onPageChange(0),
          icon: Icon(
            Icons.home,
            color: Colors.white,
          )),
      IconButton(
          onPressed: () => onPageChange(1),
          icon: Icon(
            Icons.search,
            color: Colors.white,
          )),
      IconButton(
          onPressed: () => onPageChange(2),
          icon: Icon(
            Icons.library_music_outlined,
            color: Colors.white,
          )),
    ];
    return SizedBox(
      height: kBottomSideTotalHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          PlayerNarrow(rap[0]),
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
