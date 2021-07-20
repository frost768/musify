// Home Page
String get homeGreetingTitle {
  int now = DateTime.now().hour;
  print(now);
  bool isMorning = now >= 8 && now <= 12;
  bool isNoon = now >= 12 && now <= 18;
  if (isMorning)
    return 'Günaydın';
  else if (isNoon)
    return 'Tünaydın';
  else
    return 'İyi akşamlar';
}

const String homeRecentlyPlayed = 'Yakında Çalınanlar';
const String homeUniqueSelections = 'Benzersiz Seçimlerin';
const String homeListenAgain = 'Geri Atla';
const String homePageCardSampleSubtitle =
    'Eminem, Logic, Hopsin ve daha fazlası';
const String homePageCardSampleTitle = 'Başlık';

// Custom slider
const String homePageCustomHeaderMoreLikeThis = 'BUNUN GİBİ DAHA FAZLA';
const String homePageCustomHeaderForFans = 'HAYRANLARI İÇİN';

// Create Playlist
const String createPlaylistTitle = 'Çalma listene bir isim ver.';
const String createPlaylistCancel = 'İPTAL';
const String createPlaylistCreate = 'OLUŞTUR';
const String createPlaylistSkip = 'ATLA';

// Library
const String libraryHeaderMusic = 'Müzik';
const String libraryHeaderPodcasts = "Podcast'ler";
const String libraryTabPlaylists = 'Çalma Listeleri';
const String libraryTabArtists = 'Sanatçılar';
const String libraryTabAlbums = 'Albümler';
const String libraryListTileCreatePlaylist = 'Çalma listesi oluştur';
const String libraryListTileLikedSongs = 'Beğenilen Şarkılar';

// Search
const String searchViewSliverSearch = 'Ara';
const String searchViewCheckOutAll = 'Hepsine göz at';
const String searchBarPlaceholder = "Sanatçılar, şarkılar veya podcast'ler";

// Player Narrow
const String playerNarrowAvaiableDevices = 'Kullanılabilir Cihazlar';

// Other
const String kPlaylistGenericName = 'Çalma listem No.';
