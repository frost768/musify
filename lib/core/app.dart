import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/components/bottom_nav_bar.dart';
import 'package:spotify_clone/core/routes.dart';
import 'package:spotify_clone/views/views.dart';

final List<Widget> _pages = [
  HomeView(),
  SearchView(),
  LibraryView(),
  LikedSongs()
];
final PageController pageController = PageController();
void onPageChange(int index) {
  pageController.jumpToPage(index);
}

class SpotifyClone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          primaryColor: kMainColor,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.green)),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      routes: routes,
      home: Scaffold(
        backgroundColor: kMainBackColor,
        body: PageView(
          children: _pages,
          controller: pageController,
          onPageChanged: onPageChange,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
