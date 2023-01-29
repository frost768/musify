import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/components/bottom_nav_bar.dart';
import 'package:spotify_clone/core/routes.dart';
import 'package:spotify_clone/views/views.dart';

final List<Widget> _pages = [
  HomeView(),
  SearchView(),
  LibraryView(),
];
final PageController pageController = PageController();
void onPageChange(int index) {
  pageController.jumpToPage(index);
}

class SpotifyClone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeData = ThemeData(
      colorScheme: ColorScheme.dark(),
      appBarTheme: AppBarTheme(color: kMainBackColor),
      primaryIconTheme: IconThemeData(color: Colors.white),
      scaffoldBackgroundColor: kMainBackColor,
      textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.green),
      textTheme: TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.white, backgroundColor: Colors.transparent),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.green),
      chipTheme: ChipThemeData(
        shape: StadiumBorder(side: BorderSide(color: Colors.grey, width: 1)),
        backgroundColor: Colors.black,
        selectedColor: Colors.green,
      ),
    );
    return GetMaterialApp(
      theme: themeData,
      routes: routes,
      home: Scaffold(
        extendBody: true,
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
