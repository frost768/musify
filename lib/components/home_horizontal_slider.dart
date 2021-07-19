import 'package:flutter/material.dart';
import 'package:spotify_clone/components/home_page_card.dart';
import 'package:spotify_clone/consts.dart';

class HomeHorizontalSlider extends StatelessWidget {
  final String title;
  HomeHorizontalSlider(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            child: Text(
              title,
              style: kHeadingTitle,
            ),
          ),
          Container(
            height: 150,
            margin: kMarginTop10,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(10, (index) => HomePageCard()),
            ),
          )
        ],
      ),
    );
  }
}
