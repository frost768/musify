import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/components/explicit_widget.dart';
import 'package:spotify_clone/components/playlist_tile.dart';
import 'package:spotify_clone/components/track_tile.dart';
import 'package:spotify_clone/controllers/player_controller.dart';
import 'package:spotify_clone/controllers/user_controller.dart';
import 'package:spotify_clone/models/search_result.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/services/api_service.dart';

class Search extends SearchDelegate {
  Search()
      : super(
            keyboardType: TextInputType.text,
            searchFieldLabel: 'Ne dinlemek istiyorsun?',
            searchFieldStyle: TextStyle(fontSize: 18));

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Container(),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return NewWidget(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return GetBuilder(
        init: UserController(),
        builder: (UserController user) {
          if (user.recentSearchs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sevdiğini çal',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text('Sanatçı, şarkı, podcast ve daha fazlasını ara'),
                ],
              ),
            );
          }
          return ListView(
            children: [
              ListTile(title: Text('Yakındaki Aramalar')),
              ...user.recentSearchs.map((e) => SearchTile(e)).toList(),
              ListTile(
                title: Text('Son arananları temizle'),
                onTap: () => user.recentSearchs.clear(),
              ),
            ],
          );
        });
  }
}

class NewWidget extends StatefulWidget {
  const NewWidget({
    Key? key,
    required this.query,
  }) : super(key: key);

  final String query;

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  @override
  void initState() {
    super.initState();
    fetch();
  }

  fetch() async {
    response = await ApiService().search(widget.query);
    setState(() {});
  }

  SearchResult? response;
  @override
  Widget build(BuildContext context) {
    if (response == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Expanded(child: FilterChips()),
        Text(response!.data.length.toString()),
        Expanded(
          flex: 12,
          child: NotificationListener<ScrollEndNotification>(
            onNotification: (notification) {
              var reachedEnd = notification.metrics.pixels >=
                  notification.metrics.maxScrollExtent - 200;
              if (reachedEnd) {
                response!.nextResults.then((value) {
                  response!.albumList.addAll(value.albumList);
                  response!.artistList.addAll(value.artistList);
                  response!.data.addAll(value.data);
                  response!.next = value.next;
                });
                print(response!.data.length.toString() +
                    '  -  ' +
                    response!.total.toString());
              }
              setState(() {});
              return false;
            },
            child: ListView.builder(
                itemCount: response!.all.length,
                itemBuilder: (context, index) {
                  var e = response!.all[index];
                  return SearchTile(e);
                }),
          ),
        )
      ],
    );
  }
}

class FilterChips extends StatefulWidget {
  const FilterChips({key});

  @override
  State<FilterChips> createState() => _FilterChipsState();
}

class _FilterChipsState extends State<FilterChips> {
  Map<String, String> chipList = {
    'result': 'En İyi Sonuçlar',
    'artist': 'Sanatçılar',
    'track': 'Şarkılar',
    'album': 'Albümler',
  };
  @override
  Widget build(BuildContext context) {
    return ListView(
        scrollDirection: Axis.horizontal,
        children: chipList.entries
            .map((e) => Chip(
                  label: Text(e.value),
                ))
            .toList());
  }
}

class SearchTile extends StatelessWidget {
  dynamic e;
  SearchTile(this.e, {key});
  late Widget subtitle;
  late String title;
  late Widget leading;
  Widget? trailing;

  void _onTap() {
    var user = Get.find<UserController>();
    user.recentSearchs.add(e);
    switch (e.type) {
      case 'artist':
        return null;
      case 'track':
        var player = Get.find<PlayerController>();
        player.playTrack(e);
        break;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (e.type) {
      case 'artist':
        title = e.name;
        subtitle = Text(resolveType(e.type));
        leading = CircleAvatar(
            radius: 30, backgroundImage: Image.network(e.pictureBig).image);
        break;
      case 'track':
        title = e.title;
        subtitle = !e.explicitLyrics
            ? Text(resolveType(e.type) + ' - ' + (e as Track).artist.name)
            : Row(
                children: [
                  ExplicitWidget(),
                  Text(resolveType(e.type) + ' - ' + (e as Track).artist.name)
                ],
              );
        leading = Image.network(e.album.coverBig);
        trailing = IconButton(
            onPressed: () {
              showBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    height: Get.height,
                    width: Get.width,
                    child: Column(children: [
                      Text(e.title),
                      Text(e.artist.name),
                      ListTile(
                        title: Text('Sıraya ekle'),
                        onTap: () {
                          Get.back();
                          var player = Get.find<PlayerController>();
                          player.addToPlaylist(e);
                        },
                      )
                    ]),
                  );
                },
              );
            },
            icon: Icon(Icons.more_vert));
        break;
      default:
        title = e.title;
        subtitle = Text(resolveType(e.type));
        leading = Image.network(e.coverBig);
        break;
    }
    return ListTile(
      leading: SizedBox(width: 60, height: 60, child: leading),
      title: Text(title),
      subtitle: subtitle,
      trailing: trailing,
      onTap: _onTap,
    );
    //   switch (e.type) {
    //     case 'artist':
    //       e = e as Artist;
    //       return ArtistListTile(e.name, e.pictureBig);
    //     case 'track':
    //       e = e as Track;
    //       var player = Get.find<PlayerController>();
    //       return ListTile(
    //         leading: Image.network(e.album.coverMedium),
    //         trailing: IconButton(
    //           icon: Icon(Icons.more_vert),
    //           onPressed: () => showBottomSheet(
    //             context: context,
    //             builder: (context) {
    //               return Container(
    //                 height: Get.height,
    //                 width: Get.width,
    //                 child: Column(children: [
    //                   Text(e.title),
    //                   Text(e.artist.name),
    //                   ListTile(
    //                     title: Text('Sıraya ekle'),
    //                     onTap: () {
    //                       Get.back();
    //                       player.addToPlaylist(e);
    //                     },
    //                   )
    //                 ]),
    //               );
    //             },
    //           ),
    //         ),
    //         title: Text(e.title),
    //         subtitle: Row(
    //           children: [
    //             if (e.explicitLyrics) ExplicitWidget(),
    //             Text('${resolveType(e.type)} - ${e.artist.name}'),
    //           ],
    //         ),
    //         onTap: () => player.playTrack(e),
    //       );
    //     default:
    //       e = e as Album;
    //       return PlaylistTile(e.title, coverUrl: e.coverXl);
    //   }
    // }
  }
}
