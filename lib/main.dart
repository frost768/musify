import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/controllers/player_controller.dart';
import 'package:spotify_clone/controllers/user_controller.dart';
import 'package:spotify_clone/core/app.dart';
import 'package:spotify_clone/data/albums.dart';
import 'package:spotify_clone/data/artists.dart';

void main() {
  Get.put(UserController());
  Get.put(PlayerController());
  initTracks();
  initAlbums();
  runApp(SpotifyClone());
}
