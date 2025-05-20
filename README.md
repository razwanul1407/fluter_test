# fluter_test

## Version

- Flutter Version 3.29.3
- using FVM for Version Control

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

## Author
