import 'package:flutter/material.dart';
import 'package:spotify_clone/components/home_horizontal_slider.dart';
import 'package:spotify_clone/consts.dart';

TextStyle kTableTitle =
    TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15);

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  var boxDecoration = BoxDecoration(
      gradient: RadialGradient(
          center: Alignment.topLeft,
          stops: [0, 1],
          colors: [Colors.greenAccent, kMainColor]));
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: kMarginLeft10,
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        SettingsBar(),
        HomePlaylistSection(),
        HomeHorizontalSlider('Yakında Çalınanlar'),
        HomeHorizontalSlider('Benzersiz Seçimlerin'),
        HomeHorizontalSlider('Geri Atla'),
      ]),
    );
  }
}

class SettingsBar extends StatelessWidget {
  const SettingsBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.settings,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

class HomePlaylistSection extends StatelessWidget {
  const HomePlaylistSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  'Günaydın',
                  style: kHeadingTitle,
                )),
            Expanded(
              flex: 6,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: List.generate(
                        3,
                        (index) => Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  margin: kMarginLeft10,
                                  child: Text(
                                    'Başlık',
                                    style: kTableTitle,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: List.generate(
                        3,
                        (index) => Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    margin: kMarginLeft10,
                                    child: Text(
                                      'Başlık',
                                      style: kTableTitle,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
