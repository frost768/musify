import 'package:flutter/material.dart';
import 'package:spotify_clone/components/search_page.dart';
import 'package:spotify_clone/views/views.dart';

class SearchBarPlaceholder extends StatelessWidget {
  const SearchBarPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: kMainColor, borderRadius: BorderRadius.circular(5)),
      child: GestureDetector(
        onTap: () => showSearch(context: context, delegate: Search()),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.search),
            ),
            Text(
              searchBarPlaceholder,
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
