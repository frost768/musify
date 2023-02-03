import 'package:flutter/material.dart';
import 'package:spotify_clone/components/home_page_card.dart';

class HomeHorizontalSlider extends StatelessWidget {
  Widget? header;
  List<Widget>? children = [];
  HomeHorizontalSlider({
    this.header,
    this.children,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header != null)
            Container(
              margin: const EdgeInsets.only(left: 15, bottom: 10),
              height: 50,
              child: header,
            ),
          Container(
            height: 180,
            child: ListView.separated(
              padding: const EdgeInsets.only(left: 15),
              itemBuilder: (context, index) => HomePageCard(),
              separatorBuilder: (context, index) => SizedBox(width: 15),
              itemCount: 8,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }
}
