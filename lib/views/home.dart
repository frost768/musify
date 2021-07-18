import 'package:flutter/material.dart';
import 'package:spotify_clone/consts.dart';

TextStyle kHeadingTitle =
    TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25);
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
      padding: const EdgeInsets.only(left: 10),
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Container(
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
        ),
        Container(
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
                                      margin: const EdgeInsets.only(left: 10),
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
                                        margin: const EdgeInsets.only(left: 10),
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
            )),
        HomeHorizontalSlider('Yakında Çalınanlar'),
        HomeHorizontalSlider('Benzersiz Seçimlerin'),
        HomeHorizontalSlider('Geri Atla'),
      ]),
    );
  }
}

class HomeHorizontalSlider extends StatelessWidget {
  String title = '';
  HomeHorizontalSlider(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Text(
            title,
            style: kHeadingTitle,
          )),
          Expanded(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                    10,
                    (index) => Container(
                          margin: const EdgeInsets.only(left: 10),
                          // color: Colors.green,
                          width: 100,
                          // height: 100,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.rectangle),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 4, child: Placeholder()),
                              Expanded(
                                child: Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Başlık',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              )
                            ],
                          ),
                        )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
