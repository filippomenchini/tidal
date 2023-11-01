# Tidal Developer Portal API Library

A Dart library for connecting to and interacting with the Tidal Developer Portal APIs.

## Features

- Provides easy access to Tidal's API described on the Tidal Developer Portal.
- Well-documented and structured for developer convenience.

### Implemented APIs

- [x] Authorization
- [x] Album API
- [x] Artist API
- [ ] Track API
- [ ] Video API
- [ ] Search API

## Getting Started

### Installation

To use this library, add it to your `pubspec.yaml`:

```yaml
dependencies:
  tidal: <latest-version>
```

Then run

```shell
dart pub get
```

## Usage

You can start using the library by initializing a Tidal instance and making requests to Tidal's API. Here's a basic example:

```dart
import 'package:tidal/tidal.dart';

void main() async {
  final clientId = 'your_client_id';
  final clientSecret = 'your_client_secret';

  final tidal = await Tidal.initialize(clientId: clientId, clientSecret: clientSecret);

  // Use the Tidal instance to interact with the API.
}
```

## Additional information

- For more information on the available APIs, visit [Tidal Devloper Portal](https://developer.tidal.com/).
- Contributions are welcome, visit the [GitHub repo page](https://github.com/filippomenchini/tidal).
- File issues or provide feedback on the [GitHub issue tracker](https://github.com/filippomenchini/tidal/issues).
