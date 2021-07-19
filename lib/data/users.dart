import 'package:spotify_clone/models/user.dart';

final User spotifyUser = User(0, 'Spotify');
final List<User> users =
    List.generate(4, (index) => User(index, 'User $index'));
