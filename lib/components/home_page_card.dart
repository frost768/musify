import 'package:flutter/material.dart';
import 'package:spotify_clone/consts.dart';

class HomePageCard extends StatelessWidget {
  const HomePageCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: kMarginLeft10,
      width: 150,
      decoration:
          BoxDecoration(color: Colors.transparent, shape: BoxShape.rectangle),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 4, child: Placeholder()),
          Expanded(
            child: Container(
                margin: kMarginTop10,
                child: Text(
                  'Başlık',
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
