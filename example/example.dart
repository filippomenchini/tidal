import 'package:tidal/tidal.dart';

void main(List<String> args) async {
  final tidalClientId = String.fromEnvironment('TIDAL_CLIENT_ID');
  final tidalClientSecret = String.fromEnvironment('TIDAL_CLIENT_SECRET');

  final tidal = await Tidal.initialize(
    clientId: tidalClientId,
    clientSecret: tidalClientSecret,
  );

  final jayz = await tidal.artist.getSingleArtist(
    id: "7804",
    countryCode: "US",
  );

  // Prints
  // ID: 7804
  // Name: JAY Z
  print(jayz.toString());

  // Make sure to dispose the client when you're done.
  tidal.dispose();
}
