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

  final jayz = await tidal.artist.getSingleArtist(
    id: "7804",
    countryCode: "US",
  );

  print("$jayz\n");

  final multipleArtists = await tidal.artist.getMultipleArtists(
    ids: [
      "7804",
      "1566",
    ],
    countryCode: "US",
  );

  print("${multipleArtists.items}\n");

  final imThatGirl = await tidal.track.getSingleTrack(
    id: "251380837",
    countryCode: "US",
  );

  print("$imThatGirl\n");

  final renaissance = await tidal.album.getSingleAlbum(
    albumId: "251380836",
    countryCode: "US",
  );

  print("$renaissance\n");

  final killJayZVideo = await tidal.video.getSingleVideo(
    id: "75623239",
    countryCode: "US",
  );

  print("$killJayZVideo\n");

  // Make sure to dispose the client when you're done.
  tidal.dispose();
}
