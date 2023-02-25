import 'package:flutter/material.dart';
import 'package:spotify_clone/core/routes.dart';
import 'package:spotify_clone/core/theme.dart';
import 'package:spotify_clone/views/views.dart';

class AndroidTransitions extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    var tween =
        Tween(begin: 0.0, end: 100.0).chain(CurveTween(curve: Curves.ease));

    return FadeTransition(
      opacity: animation.drive(tween),
      child: child,
    );
  }
}

class SpotifyClone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: 'Home',
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
    );
  }
}
