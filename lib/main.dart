import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/app.dart';
import 'package:spotify_clone/services/cache_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CacheService().init();
  runApp(ProviderScope(child: SpotifyClone()));
}
