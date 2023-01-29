import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/controllers/player_controller.dart';
import 'package:spotify_clone/controllers/user_controller.dart';
import 'package:spotify_clone/core/app.dart';
import 'package:spotify_clone/services/cache_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CacheService.init();
  Get.put(UserController());
  Get.put(PlayerController());
  runApp(SpotifyClone());
}
