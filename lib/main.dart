import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/components/player_narrow.dart';
import 'package:spotify_clone/controllers/player_controller.dart';
import 'package:spotify_clone/controllers/user_controller.dart';
import 'package:spotify_clone/views/create_playlist.dart';
import 'package:spotify_clone/views/views.dart';

void main() {
  Get.put(UserController());
  Get.put(PlayerController());
  runApp(MyApp());
}

final List<Widget> _pages = [HomeView(), SearchView(), LibraryView()];

class MyApp extends StatelessWidget {
  final PageController _pageController = PageController();
  void onPageChange(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primaryColor: kMainColor, accentColor: Colors.green),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      routes: {
        'CreatePlaylist': (_) => CreatePlaylist(),
      },
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
