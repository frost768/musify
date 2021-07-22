import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/core/consts.dart';
import 'package:spotify_clone/controllers/user_controller.dart';
import 'package:spotify_clone/data/playlists.dart';
import 'package:spotify_clone/views/views.dart';

class HomePlaylistSection extends StatelessWidget {
  final backgroundGradient = BoxDecoration(
      gradient: RadialGradient(
    center: Alignment.topLeft,
    radius: 1.8,
    stops: [0, 0.3],
    colors: [Colors.white10, kMainBackColor],
  ));
  final playlistAlbumArtLeading = BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
      color: Colors.white);
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
            decoration: backgroundGradient,
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
                            .map((e) => ListTile(
                                  leading: Container(
                                    width: 60,
                                    decoration: playlistAlbumArtLeading,
                                  ),
                                  title: Text(
                                    e.name,
                                    // overflow: TextOverflow.ellipsis,
                                    style: kTableTitle,
                                  ),
                                ))
                            .toList()))
              ],
            ),
          )),
    );
  }
}
