import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/core/consts.dart';
import 'package:spotify_clone/controllers/user_controller.dart';
import 'package:spotify_clone/data/playlists.dart';
import 'package:spotify_clone/views/views.dart';

class HomePlaylistSection extends StatelessWidget {
  final boxDecoration = BoxDecoration(
      gradient: RadialGradient(
    center: Alignment.topLeft,
    stops: [0, 0.1, 0.2, 1],
    colors: [
      Colors.amber.shade300,
      Colors.amber.shade200,
      Colors.amber.shade100,
      kMainBackColor
    ],
  ));
  HomePlaylistSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: UserController(),
      builder: (UserController user) => Container(
          height: 320,
          child: Container(
            decoration: boxDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: kMarginLeft10,
                          child: Text(
                            homeGreetingTitle,
                            style: kHeadingTitle,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.settings,
                              )
                            ],
                          ),
                        )
                      ],
                    )),
                Container(
                    height: 230,
                    child: GridView.count(
                      childAspectRatio: 3 / 1,
                      crossAxisCount: 2,
                      physics: NeverScrollableScrollPhysics(),
                      children: playlists
                          .map((e) => Container(
                                margin: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      margin: kMarginLeft10,
                                      width: 100,
                                      child: Text(
                                        e.name,
                                        overflow: TextOverflow.fade,
                                        style: kTableTitle,
                                      ),
                                    )
                                  ],
                                ),
                              ))
                          .toList(),
                    ))
              ],
            ),
          )),
    );
  }
}
