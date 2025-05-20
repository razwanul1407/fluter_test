# fluter_test

## Features

- User list with pagination (10 items per page)
- Real-time search across GitHub users
- Responsive UI with smooth animations
- Offline support with local caching
- Pull-to-refresh functionality
- Error handling and retry mechanisms
- Network status awareness

## Architecture

The application follows Clean Architecture principles with:

- **Presentation Layer**: BLoC pattern for state management
- **Domain Layer**: Entities and use cases
- **Data Layer**: Repository implementation with remote and local data sources

## Tech Stack

- **State Management**: BLoC
- **Networking**: Dio with interceptors
- **Local Storage**: SharedPreferences
- **Dependency Injection**: GetIt
- **Serialization**: json_serializable
- **Linting**: Flutter recommended linter rules


## APP ENVIRONMENT

To run this project, you will need to set fvm in windows. 

`Flutter 3.29.3`

`Dart 3.7.2`


## Installation

Install project using following bash command.

```bash
  fvm flutter pub get
```


Then run this command for android initiation

```bash
  fvm flutter run
```


## Author

- [@razwanul1407](https://github.com/razwanul1407)
