import 'package:flutter/material.dart';
import 'package:spotify_clone/views/views.dart';

class SearchBarPlaceholder extends StatelessWidget {
  const SearchBarPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: kMainColor, borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search),
          Text(
            "Sanatçılar, şarkılar veya podcast'ler",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
