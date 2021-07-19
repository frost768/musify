import 'package:flutter/material.dart';
import 'package:spotify_clone/components/searchbar_placeholder.dart';
import 'package:spotify_clone/consts.dart';

class SearchView extends StatelessWidget {
  SearchView({Key? key}) : super(key: key);
  final dec =
      BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(5));
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              flexibleSpace: Center(
                child: Container(
                  height: 100,
                  child: Text('Ara'),
                ),
              ),
            ),
          ];
        },
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SearchBarPlaceholder(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      child: Center(
                        child: Text(
                          'Hepsine göz at',
                          style: kHeadingTitle.copyWith(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 3 / 2,
                    children: List.generate(
                        10,
                        (index) => Container(
                              decoration: dec,
                            )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
