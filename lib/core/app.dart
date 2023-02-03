import 'package:flutter/material.dart';
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

class AndroidTransitions extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: 0.0, end: 100.0).chain(CurveTween(curve: curve));

    return FadeTransition(
      opacity: animation.drive(tween),
      child: child,
    );
  }
}

class SpotifyClone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeData = ThemeData(
      useMaterial3: false,
      indicatorColor: Colors.green.shade800,
      scaffoldBackgroundColor: kMainBackColor,
      colorScheme: ColorScheme.dark().copyWith(primary: Colors.green.shade800),
      textTheme: Typography.whiteRedmond,
      applyElevationOverlayColor: true,
      toggleableActiveColor: Colors.green,
      appBarTheme: AppBarTheme(color: kMainBackColor),
      pageTransitionsTheme: PageTransitionsTheme(
          builders: {TargetPlatform.android: AndroidTransitions()}),
      sliderTheme: SliderThemeData(
          inactiveTrackColor: Color.fromARGB(0, 80, 68, 68),
          activeTrackColor: Color.fromARGB(255, 38, 38, 38),
          thumbColor: Color.fromARGB(255, 38, 38, 38),
          trackHeight: 3,
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5.0),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 5.0),
          trackShape: RectangularSliderTrackShape()),
      primaryIconTheme: IconThemeData(color: Colors.white),
      textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.green),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.white, backgroundColor: Colors.transparent),
      chipTheme: ChipThemeData(
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
          shape: StadiumBorder(
              side: BorderSide(color: Colors.green.shade800, width: 2)),
          backgroundColor: Colors.black,
          selectedColor: Colors.green.shade800,
          showCheckmark: false),
    );
    return MaterialApp(
      theme: themeData,
      routes: routes,
      home: Scaffold(
        extendBody: true,
        body: PageView(
          children: _pages,
          controller: pageController,
          onPageChanged: onPageChange,
          physics: const NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
