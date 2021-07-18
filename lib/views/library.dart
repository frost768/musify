import 'package:flutter/material.dart';

class LibraryView extends StatelessWidget {
  LibraryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            print(innerBoxIsScrolled);
            return [
              SliverAppBar(
                title: Text('Ara'),
                expandedHeight: 200,
                snap: true,
                floating: true,
                bottom: TabBar(indicatorColor: Colors.green, tabs: [
                  Tab(
                    text: 'Çalma Listeleri',
                  ),
                  Tab(
                    text: 'Sanatçılar',
                  ),
                  Tab(
                    text: 'Albümler',
                  )
                ]),
              ),
            ];
          },
          body: TabBarView(children: [
            ListView(
              children: [
                ListTile(
                  leading: Container(
                    child: Icon(Icons.add),
                  ),
                  title: Text('Çalma listesi oluştur'),
                )
              ],
            ),
            ListView(
              children: [
                ListTile(
                  leading: Container(
                    child: Icon(Icons.add),
                  ),
                  title: Text('Çalma listesi oluştur'),
                )
              ],
            ),
            ListView(
              children: [
                ListTile(
                  leading: Container(
                    child: Icon(Icons.add),
                  ),
                  title: Text('Çalma listesi oluştur'),
                )
              ],
            ),
          ])),
    );
  }
}
