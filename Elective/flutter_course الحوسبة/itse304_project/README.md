# ITSE304 Project

This Flutter project is developed for the course 'Cross Platform Applications' for Android. It demonstrates the use of the BLoC pattern for state management, user authentication, and navigation.

## Features

- User Authentication (Sign Up, Login, Logout)
- Navigation with Bottom Navigation Bar
- Profile Management
- State Management using BLoC

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/)

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/arousi/itse304_project.git
   cd itse304_project
   ```

2. Install dependencies:
   ```sh
   flutter pub get
   ```

3. Run the app:
   ```sh
   flutter run
   ```

### Project Structure

- `lib/`: Contains the main source code.
  - `cubit/`: Contains BLoC (Business Logic Component) files for state management.
    - `auth/`: Authentication-related BLoC files.
    - `navigation/`: Navigation-related BLoC files.
    - `profile/`: Profile-related BLoC files.
  - `gui/`: Contains the UI files.
    - `auth/`: Authentication-related UI files.
    - `main/`: Main screen UI files.
    - `profile/`: Profile screen UI files.
  - `widgets/`: Contains reusable widgets.
  - `shared_preferences.dart`: Utility class for handling shared preferences.

## Usage

### Authentication

- **Sign Up**: Create a new user account.
- **Login**: Authenticate an existing user.
- **Logout**: Sign out the current user.

### Navigation

- **Home Screen**: The main screen of the app.
- **Profile Screen**: The user's profile screen.

### State Management

- **AuthCubit**: Manages authentication state.
- **NavigationCubit**: Manages navigation state.
- **ProfileCubit**: Manages profile state.

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch:
   ```sh
   git checkout -b feature/your-feature
   ```
3. Commit your changes:
   ```sh
   git commit -m 'Add some feature'
   ```
4. Push to the branch:
   ```sh
   git push origin feature/your-feature
   ```
5. Open a pull request.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Acknowledgements

- Flutter
- BLoC
- Android Studio
- Visual Studio Code

## Contact

For any inquiries, please contact arousi on GitHub.