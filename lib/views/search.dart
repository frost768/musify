import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/components/bottom_nav_bar_height.dart';
import 'package:spotify_clone/components/searchbar_placeholder_sliver.dart';
import 'package:spotify_clone/providers/playlist_provider.dart';
import 'package:spotify_clone/views/views.dart';

class SearchView extends ConsumerWidget {
  SearchView({Key? key}) : super(key: key);
  final dec =
      BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(5));

  Color get randomColor => Color.fromARGB(
      255, Random().nextInt(255), Random().nextInt(255), Random().nextInt(255));
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 40, 20),
                child: Text(
                  searchViewSliverSearch,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
            ),
            SliverPersistentHeader(
                pinned: true, delegate: SearchBarPlaceholderSliver()),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Center(
                  child: Text(
                    searchViewBrowseAll,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ),
            ref.watch(genreProvider).maybeWhen(
                orElse: () => SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator())),
                data: (data) => SliverGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 3 / 1.7,
                      children: [
                        Container(
                            decoration: dec.copyWith(color: randomColor),
                            child: _FeaturedCard(
                                data.last.pictureXl, data.last.name)),
                        Container(
                            decoration: dec.copyWith(color: randomColor),
                            child: _FeaturedCard(
                                data.first.pictureXl, 'Top Listeler')),
                        ...data
                            .take(data.length - 1)
                            .map((e) => Container(
                                  decoration: dec.copyWith(
                                    color: randomColor,
                                  ),
                                  child: _FeaturedCard(e.pictureXl, e.name),
                                ))
                            .toList()
                      ],
                    )),
            BottomNavBarHeight.sliver
          ],
        ),
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  final String albumImage;
  final String genreName;

  const _FeaturedCard(this.albumImage, this.genreName, {key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      _FeaturedCardText(genreName),
      _FeaturedCardImage(albumImage)
    ]);
  }
}

class _FeaturedCardText extends StatelessWidget {
  final String genreName;
  const _FeaturedCardText(
    this.genreName, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        genreName,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
          shadows: [
            BoxShadow(
                spreadRadius: 50, offset: Offset(2, 2), color: Colors.black)
          ],
        ),
      ),
    );
  }
}

class _FeaturedCardImage extends StatelessWidget {
  final String albumImage;

  const _FeaturedCardImage(
    this.albumImage, {
    Key? key,
  }) : super(key: key);

  BoxDecoration boxDecoration(String albumImage) => BoxDecoration(
        boxShadow: [
          BoxShadow(
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset.fromDirection(10)),
        ],
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: Image.network(albumImage).image),
      );
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      left: 120,
      child: Transform.rotate(
        angle: 3.14 / 8,
        child: Container(
          width: 90,
          height: 90,
          decoration: boxDecoration(albumImage),
        ),
      ),
    );
  }
}
