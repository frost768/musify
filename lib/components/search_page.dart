import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/components/explicit_widget.dart';
import 'package:spotify_clone/components/filter_chips.dart';
import 'package:spotify_clone/models/search_result.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/providers/player_provider.dart';
import 'package:spotify_clone/providers/playlist_provider.dart';
import 'package:spotify_clone/services/api_service.dart';

class Search extends SearchDelegate {
  Search()
      : super(
            keyboardType: TextInputType.text,
            searchFieldLabel: 'Ne dinlemek istiyorsun?',
            searchFieldStyle: TextStyle(fontSize: 18));

  @override
  List<Widget>? buildActions(BuildContext context) {
    return query.isEmpty
        ? [IconButton(onPressed: () {}, icon: Icon(Icons.photo_camera))]
        : [IconButton(onPressed: () => query = '', icon: Icon(Icons.clear))];
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
    if (query.length > 0) {
      return NewWidget(query: query);
    }
    if ([].isEmpty) {
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
        // ...[].map((e) => SearchTile(e)).toList(),
        ListTile(
          title: Text('Son arananları temizle'),
          // onTap: () => user.recentSearchs.clear(),
        ),
      ],
    );
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
    if (widget.query.isNotEmpty) {
      response = await ApiService().search(widget.query);
      setState(() {});
    }
  }

  SearchResult? response;
  @override
  Widget build(BuildContext context) {
    if (response == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        SearchPageFilterChips(),
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
              }
              setState(() {});
              return response!.next == null;
            },
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final filter = ref.watch(searchPageFilterProvider);
                if (filter == 'album') {
                  return AlbumSearchView(response: response);
                }

                return ListView.builder(
                    itemCount: response!.all
                        .where((e) => filter.isEmpty ? true : e.type == filter)
                        .length,
                    itemBuilder: (context, index) {
                      var e = response!.all
                          .where(
                              (e) => filter.isEmpty ? true : e.type == filter)
                          .elementAt(index);
                      return SearchTile(e, filter);
                    });
              },
            ),
          ),
        ),
        // BottomNavBar()
      ],
    );
  }
}

class AlbumSearchView extends StatelessWidget {
  const AlbumSearchView({
    Key? key,
    required this.response,
  }) : super(key: key);

  final SearchResult? response;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        crossAxisCount: 2,
        children: response!.albumList
            .map((e) => GridTile(
                  footer: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      e.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  child: Container(
                    foregroundDecoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black,
                            Colors.transparent,
                          ],
                          stops: [
                            0.1,
                            1,
                          ]),
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: Image.network(e.coverBig).image)),
                  ),
                ))
            .toList());
  }
}

class SearchTile extends ConsumerWidget {
  dynamic e;
  String filter;
  SearchTile(this.e, this.filter, {key});
  late Widget? subtitle;
  late String title;
  late Widget leading;
  Widget? trailing;
  TextStyle titleStyle = const TextStyle();
  void _onTap(WidgetRef ref, dynamic e) {
    // user.recentSearchs.add(e);
    switch (e.type) {
      case 'artist':
        return null;
      case 'track':
        ref.read(playerStateProvider.notifier).play(track: e, fromSearch: true);
        break;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            ? Text((e as Track).artist.name)
            : Row(
                children: [
                  ExplicitWidget(),
                  Text('${filter == 'track' ? (e as Track).artist.name : [
                      resolveType(e.type),
                      (e as Track).artist.name
                    ].join(' - ')}')
                ],
              );
        leading = Image.network(e.album.coverBig);
        trailing = IconButton(
            onPressed: () {
              showBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(children: [
                      Text(e.title),
                      Text(e.artist.name),
                      ListTile(
                        title: Text('Sıraya ekle'),
                        onTap: () {
                          Navigator.of(context).pop();
                          ref.read(playListProvider.notifier).addToPlaylist(e);
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
    if (filter.isNotEmpty && e.type != 'track') subtitle = null;
    return ListTile(
      contentPadding: e.type == 'artist' ? const EdgeInsets.all(10) : null,
      leading: SizedBox(width: 60, height: 60, child: leading),
      title: Text(title,
          style: ref.watch(currentTrackProvider)!.id == e.id
              ? titleStyle.copyWith(color: Colors.green)
              : titleStyle),
      subtitle: subtitle,
      trailing: trailing,
      onTap: () => _onTap(ref, e),
    );
  }
}
