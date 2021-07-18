import 'package:flutter/material.dart';

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
              expandedHeight: 250,
              centerTitle: true,
              floating: true,
              title: Text('Ara'),
              toolbarHeight: 250,
            ),
          ];
        },
        body: GridView.count(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 10,
          childAspectRatio: 3 / 2,
          children: List.generate(
              10,
              (index) => Container(
                    decoration: dec,
                    child: Text('dd'),
                  )),
        ));
  }
}
