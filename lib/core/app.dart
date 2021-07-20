import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/components/bottom_nav_bar.dart';
import 'package:spotify_clone/core/routes.dart';
import 'package:spotify_clone/views/views.dart';

final List<Widget> _pages = [HomeView(), SearchView(), LibraryView()];

class SpotifyClone extends StatelessWidget {
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
      routes: routes,
      home: Scaffold(
        backgroundColor: kMainBackColor,
        body: PageView(
          children: _pages,
          controller: _pageController,
          onPageChanged: onPageChange,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavBar(onPageChange),
      ),
    );
  }
}
