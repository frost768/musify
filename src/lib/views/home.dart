import 'package:flutter/material.dart';
import 'package:spotify_clone/components/bottom_nav_bar.dart';
import 'package:spotify_clone/components/bottom_nav_bar_height.dart';
import 'package:spotify_clone/components/home_playlist_section.dart';
import 'package:spotify_clone/components/home_recommendations.dart';
import 'package:spotify_clone/views/views.dart';

final List<Widget> _pages = [
  HomeView(),
  SearchView(),
  LibraryView(),
];
final PageController pageController = PageController();
void onPageChange(int index) {
  pageController.jumpToPage(index);
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        children: _pages,
        controller: pageController,
        onPageChanged: onPageChange,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar:
          Orientation.landscape == MediaQuery.of(context).orientation
              ? null
              : BottomNavBar(),
    );
  }
}

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: CustomScrollView(slivers: [
        SliverAppBar(
          toolbarHeight: 100,
          floating: true,
          pinned: true,
          snap: false,
          title: Text(homeGreetingTitle),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
            IconButton(onPressed: () {}, icon: Icon(Icons.history)),
            IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
          ],
          bottom: PreferredSize(
              preferredSize: Size(double.infinity, 50),
              child: SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      FilterChip(
                        side: BorderSide(color: kMainBackColor),
                        label: Text('Müzik'),
                        onSelected: (bool value) {},
                      ),
                      SizedBox(width: 10),
                      FilterChip(
                        side: BorderSide(color: kMainBackColor),
                        label: Text(kPodcastsAndPrograms),
                        onSelected: (bool value) {},
                      ),
                    ],
                  ),
                ),
              )),
        ),
        SliverToBoxAdapter(child: HomePlaylistSection()),
        SliverToBoxAdapter(child: HomeRecommendations()),
        BottomNavBarHeight.sliver
      ]),
    );
  }
}
