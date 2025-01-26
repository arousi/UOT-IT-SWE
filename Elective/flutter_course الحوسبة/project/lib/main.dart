import 'package:flutter/material.dart';
import 'package:project/views/auth/login.dart';
import 'package:project/views/profile/profile_page.dart';
import 'package:project/views/settings/settings.dart';

import 'views/home/home.dart';

void main() {
  runApp(const MainApp());
}

bool isLoggedIn = true;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: HomePage(),
      routes: {
        '/home': (context) => HomePage(),
        '/settings': (context) => SettingsPage(),
        '/profile': (context) => ProfilePage(),
      },
      initialRoute: '/home',
      onGenerateInitialRoutes: (initialRoute) {
        if (!isLoggedIn) {
          return [
            MaterialPageRoute(
              settings: RouteSettings(name: '/login'),
              builder: (context) {
                return LoginPage();
              },
            )
          ];
        }
        return [
          MaterialPageRoute(builder: (context) {
            return HomePage();
          })
        ];
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('unknown route ${settings.name}'),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Back'))
                ],
              ),
            ),
          );
        });
      },
      onGenerateRoute: (settings) {
        if (!isLoggedIn) {
          return MaterialPageRoute(
            settings: RouteSettings(name: '/login'),
            builder: (context) {
              return LoginPage();
            },
          );
        }
      },
    );
  }
}
