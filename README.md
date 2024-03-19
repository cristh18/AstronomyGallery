# Astronomy Gallery

Astronomy Gallery is a Flutter application that displays astronomy pictures.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

## Architecture

This project follows the BLoC (Business Logic Component) pattern for state management. The BLoC pattern separates the presentation layer from the business logic, making the codebase easier to maintain and test.

![Bloc Architecture](https://bloclibrary.dev/_astro/bloc_architecture_full.CYn-T9Ox_Z20Hwr9.webp)

![Bloc Architecture 2](https://bloclibrary.dev/_astro/architecture.DcqFXZki_HITPC.webp)

The project is structured as follows:

- `lib/`: This directory contains the main Dart code for the project.
  - `main.dart`: This is the entry point of the application.
  - `cubit/`: Contains the BLoC classes for state management.
  - `domain/models/`: Contains the data models.
  - `data/repository/`: Contains the repository classes, which handle data access.
  - `network/`: Contains the classes related to network requests.
  - `ui/`: Contains the UI code.
    - `pages/`: Contains the different pages/screens of the app.
    - `widgets/`: Contains reusable widgets.
- `test/`: Contains the unit tests for the project.
- `assets/`: Contains the assets for the project, such as images and fonts.
- `pubspec.yaml`: Contains the project metadata and dependencies.
- `.env`: Contains the environment variables for the project.

The app uses the [Retrofit](https://pub.dev/packages/retrofit) package for network requests, and the [Hive](https://docs.hivedb.dev/) package for local data storage. Unit tests are written using the [bloc_test](https://pub.dev/packages/bloc_test) and [Mockito](https://pub.dev/packages/mockito) packages.

## Built With

- [Flutter](https://flutter.dev/) - The UI framework used
- [Retrofit](https://pub.dev/packages/retrofit) - A type-safe HTTP client for Dart and Flutter
- [Dio](https://pub.dev/packages/dio) - A powerful HTTP client for Dart, which supports Interceptors, Global configuration, FormData, Request Cancellation, File downloading, Timeout etc.
- [Logger](https://pub.dev/packages/logger) - Small, easy to use and extensible logger which prints beautiful logs.
- [json_annotation](https://pub.dev/packages/json_annotation) - Classes and helper functions that support JSON code generation via the `json_serializable` package.
- [Bloc](https://bloclibrary.dev/#/) - A predictable state management library for Dart
- [Flutter Bloc](https://bloclibrary.dev/#/flutterblocoverview) - Flutter Widgets that make it easy to implement the BLoC (Business Logic Component) design pattern
- [Hive](https://docs.hivedb.dev/) - NoSQL database to store data locally
- [Hive Flutter](https://pub.dev/packages/hive_flutter) - Flutter package for Hive database
- [Flutter Dotenv](https://pub.dev/packages/flutter_dotenv) - A Flutter package for using environment variables
- [Equatable](https://pub.dev/packages/equatable) - An abstract class that helps to implement equality without needing to explicitly override == and hashCode.
- [Flutter Localizations](https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html) - Internationalizing Flutter Apps
- [Intl](https://pub.dev/packages/intl) - Contains code to deal with internationalized/localized messages, date and number formatting and parsing, bi-directional text, and other internationalization issues.
- [Mockito](https://pub.dev/packages/mockito) - Mocking framework used 
- [Bloc Test](https://pub.dev/packages/bloc_test) - A testing utility that makes it easy to test blocs and cubits

### Prerequisites

- Flutter SDK
- Dart SDK

## NASA API Key and Environment Variables

This project uses the NASA API to fetch astronomy pictures. To use the NASA API, you need to obtain an API key.

### Obtaining the NASA API Key

1. Go to the [NASA API portal](https://api.nasa.gov/).
2. Click on 'Generate API Key'.
3. Fill in the form with your First Name, Last Name, and Email. For the Application URL, you can put the URL of your GitHub repository.
4. Click on 'Signup'.
5. You will receive an email with your API key.

### Installation

1. Clone the repository: 
    - `git clone https://github.com/yourusername/AstronomyGallery.git`
2. Navigate into the cloned repository:
    - `cd AstronomyGallery`
3. Get the dependencies:
    - `flutter pub get`

### Setting up the .env file

1. Create a new file in the root of your project named `.env`.
2. Open the `.env` file and add the following line:

    ```
    NASA_API_KEY=your_nasa_api_key
    ```

    Replace `your_nasa_api_key` with the API key you obtained from the NASA API portal.

3. Save the `.env` file.

## Code Generation

This project uses code generation for certain tasks, such as JSON serialization. To generate the code, you need to run the `build_runner` command:

If you're using the Dart SDK:

```bash
dart pub run build_runner build
```

If you're using the Flutter SDK:

```bash
flutter pub run build_runner build
```

## Run the app:
`flutter run`

## Running the tests

To run the unit tests, use the following command:

`flutter test`

## Contributing

Please read `CONTRIBUTING.md` for details on our code of conduct, and the process for submitting pull requests to us.

## Authors

- Cristhian Tolosa - Initial work - [cristh18](https://github.com/cristh18)

See also the list of [contributors](https://github.com/yourusername/AstronomyGallery/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the `LICENSE.md` file for details

