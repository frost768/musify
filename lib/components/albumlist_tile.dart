import 'package:flutter/material.dart';

class AlbumListTile extends StatelessWidget {
  final String name;
  AlbumListTile(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
      ),
      title: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
