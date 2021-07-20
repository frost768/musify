import 'package:get/get.dart';
import 'package:spotify_clone/controllers/user_controller.dart';
import 'package:spotify_clone/models/album.dart';

class AlbumController extends GetxController {
  Album album;
  AlbumController(this.album);
  UserController user = Get.find<UserController>();
  void toggleLike() {
    album.isFavorite = !album.isFavorite;
    if (album.isFavorite)
      user.addToFavoriteAlbums(album);
    else
      user.removeFromAlbumFavorites(album.id);
    update();
  }
}
