# Task Manager

Task Manager is a mobile application built using Flutter, designed for efficient task management. It
follows the principles of Clean Architecture, utilizing `flutter_bloc` for state management
and `auto_route` for route management. This guide will help you set up, run, and test the
application.

## Features

- **Task Management**: Create, update, delete, and view tasks.
- **State Management**: Managed by `flutter_bloc` for predictable state handling.
- **Navigation**: Structured and type-safe routing with `auto_route`.
- **Clean Architecture**: Ensures separation of concerns and maintainability.

## Requirements

Before starting, ensure you have the following tools installed:

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK: Comes with Flutter.
- A physical device or emulator for testing.

## Installation

Follow these steps to set up the project:

1. **Clone the Repository**

```bash
git clone https://github.com/Melo567/task_manager.git

cd task_manager
```

2. **Install Dependencies**

Fetch the required packages using the following command:

```bash
flutter pub get
```

3. **Generate Auto Route Files**

Build the necessary route files using `auto_route`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Project Structure

This project adheres to Clean Architecture, with the following structure:

**Core Layers:**

- `domain/`: Contains business logic, entities, and repository interfaces.
- `data/`: Implements repositories, data sources, and models.
- `presentation/`: Houses the UI, including screens, widgets, and blocs.

## Running the Application

To run the app, follow these steps:

1. **Connect a Device or Start an Emulator**

Ensure that a device is connected or an emulator is active.

2. **Run the App**

Execute the following command:

```bash
flutter run
```

For run in ios simulator 

```shell
cd ios && pod install

flutter run
```

## Testing

To validate the application, perform the following tests:

1. **Unit Tests**

Run unit tests to verify the business logic:

```bash
flutter test
```