import 'package:tidal/tidal.dart';

void main(List<String> args) async {
  // Declare your Tidal api credentials.
  // This is just an example, store your credentials safely.
  final tidalClientId = String.fromEnvironment('TIDAL_CLIENT_ID');
  final tidalClientSecret = String.fromEnvironment('TIDAL_CLIENT_SECRET');

  // Setup the tidal client.
  final tidal = await Tidal.initialize(
    clientId: tidalClientId,
    clientSecret: tidalClientSecret,
  );

  // Fetch a specific artist.
  final jayz = await tidal.artist.getSingleArtist(
    id: "7804",
    countryCode: "US",
  );

  print("$jayz\n");

  // Fetch multiple artists with their IDs.
  final multipleArtists = await tidal.artist.getMultipleArtists(
    ids: [
      "7804",
      "1566",
    ],
    countryCode: "US",
  );

  print("${multipleArtists.items}\n");

  // Fetch a song by its ID.
  final imThatGirl = await tidal.track.getSingleTrack(
    id: "251380837",
    countryCode: "US",
  );

  print("$imThatGirl\n");

  // Fetch an album.
  final renaissance = await tidal.album.getSingleAlbum(
    albumId: "251380836",
    countryCode: "US",
  );

  print("$renaissance\n");

  // Fetch a video.
  final killJayZVideo = await tidal.video.getSingleVideo(
    id: "75623239",
    countryCode: "US",
  );

  print("$killJayZVideo\n");

  // Search something.
  final searchResult = await tidal.search.searchForCatalogItems(
    query: "jay z",
    countryCode: "US",
  );

  print("${searchResult.artists.items}\n");
  print("${searchResult.albums.items}\n");
  print("${searchResult.tracks.items}\n");
  print("${searchResult.videos.items}\n");

  // You can also search in a specific catalog category.
  final searchedArtists = await tidal.artist.search(
    query: "lupe fiasco",
    countryCode: "US",
  );

  print("${searchedArtists.items}\n");

  // Make sure to dispose the client when you're done.
  tidal.dispose();
}
