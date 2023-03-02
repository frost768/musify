import 'package:flutter/material.dart';
import 'package:spotify_clone/core/consts.dart';

class AppTheme {
  ChipThemeData get chipThemeData => ChipThemeData(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
      shape: StadiumBorder(
          side: BorderSide(color: Colors.green.shade800, width: 2)),
      backgroundColor: Colors.black,
      selectedColor: Colors.green.shade800,
      showCheckmark: false);
  SliderThemeData get sliderThemeData => SliderThemeData(
      inactiveTrackColor: Color.fromARGB(0, 80, 68, 68),
      activeTrackColor: Color.fromARGB(255, 38, 38, 38),
      thumbColor: Color.fromARGB(255, 38, 38, 38),
      trackHeight: 3,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5.0),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 5.0),
      trackShape: RectangularSliderTrackShape());
  BottomNavigationBarThemeData get bottomNavigationBarThemeData =>
      BottomNavigationBarThemeData(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(fontSize: 10),
          unselectedLabelStyle: TextStyle(fontSize: 10),
          backgroundColor: Colors.transparent);
  FloatingActionButtonThemeData get floatingActionButtonThemeData =>
      FloatingActionButtonThemeData(
          backgroundColor: Colors.green.shade800,
          foregroundColor: Colors.white,
          iconSize: 35,
          shape: CircleBorder());
  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      sliderTheme: sliderThemeData,
      chipTheme: chipThemeData.copyWith(
          labelStyle: TextStyle(color: lightColorScheme.background)),
      floatingActionButtonTheme: floatingActionButtonThemeData,
      bottomNavigationBarTheme: bottomNavigationBarThemeData.copyWith(
          selectedItemColor: lightColorScheme.primary,
          backgroundColor: lightColorScheme.background),
      colorScheme: lightColorScheme,
      textTheme: Typography.blackMountainView,
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      chipTheme: chipThemeData,
      sliderTheme: sliderThemeData,
      floatingActionButtonTheme: floatingActionButtonThemeData,
      bottomNavigationBarTheme: bottomNavigationBarThemeData,
      scaffoldBackgroundColor: darkColorScheme.background,
      colorScheme: darkColorScheme,
      textTheme: Typography.whiteMountainView,
    );
  }

  ThemeData get darkTheme2 {
    var textSelectionThemeData =
        TextSelectionThemeData(cursorColor: Colors.green);
    return ThemeData(
      useMaterial3: true,
      indicatorColor: Colors.green.shade800,
      scaffoldBackgroundColor: kMainBackColor,
      iconTheme: IconThemeData(color: Colors.white),
      listTileTheme: ListTileThemeData(iconColor: Colors.white),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(primary: Colors.green.shade800),
      textTheme: Typography.whiteHelsinki,
      appBarTheme: AppBarTheme(
        backgroundColor: kMainBackColor,
        titleTextStyle: Typography.whiteHelsinki.bodyLarge,
      ),
      sliderTheme: sliderThemeData,
      textSelectionTheme: textSelectionThemeData,
      bottomNavigationBarTheme: bottomNavigationBarThemeData,
      chipTheme: chipThemeData,
      floatingActionButtonTheme: floatingActionButtonThemeData,
    );
  }
}

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF246D00),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF99FA6E),
  onPrimaryContainer: Color(0xFF062100),
  secondary: Color(0xFF55624C),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD8E7CB),
  onSecondaryContainer: Color(0xFF131F0D),
  tertiary: Color(0xFF386667),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFBBEBEC),
  onTertiaryContainer: Color(0xFF002021),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFDFDF6),
  onBackground: Color(0xFF1A1C18),
  surface: Color(0xFFFDFDF6),
  onSurface: Color(0xFF1A1C18),
  surfaceVariant: Color(0xFFDFE4D7),
  onSurfaceVariant: Color(0xFF43483E),
  outline: Color(0xFF73796E),
  onInverseSurface: Color(0xFFF1F1EA),
  inverseSurface: Color(0xFF2F312D),
  inversePrimary: Color(0xFF7EDD55),
  shadow: Color(0xFF000000),
  surfaceTint: Color.fromARGB(255, 255, 255, 255),
  outlineVariant: Color(0xFFC3C8BB),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF7EDD55),
  onPrimary: Color(0xFF0F3900),
  primaryContainer: Color(0xFF195200),
  onPrimaryContainer: Color(0xFF99FA6E),
  secondary: Color(0xFFBCCBB0),
  onSecondary: Color(0xFF273421),
  secondaryContainer: Color(0xFF3D4B36),
  onSecondaryContainer: Color(0xFFD8E7CB),
  tertiary: Color(0xFFA0CFD0),
  onTertiary: Color(0xFF003738),
  tertiaryContainer: Color(0xFF1E4E4F),
  onTertiaryContainer: Color(0xFFBBEBEC),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color.fromARGB(255, 0, 0, 0),
  onBackground: Color(0xFFE3E3DC),
  surface: Color(0xFF1A1C18),
  onSurface: Color(0xFFE3E3DC),
  surfaceVariant: Color(0xFF43483E),
  onSurfaceVariant: Color(0xFFC3C8BB),
  outline: Color(0xFF8D9287),
  onInverseSurface: Color(0xFF1A1C18),
  inverseSurface: Color(0xFFE3E3DC),
  inversePrimary: Color(0xFF246D00),
  shadow: Color(0xFF000000),
  surfaceTint: Color.fromARGB(255, 0, 0, 0),
  outlineVariant: Color(0xFF43483E),
  scrim: Color(0xFF000000),
);
