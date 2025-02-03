import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itse304_project/cubit/auth/auth_cubit.dart';
import 'package:itse304_project/shared_preferences.dart';

import 'cubit/navigation/nav_cubit.dart';
import 'gui/auth/loginscreen.dart';
import 'gui/main/homescreen.dart';
import 'gui/profile/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => NavigationCubit()),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Form w/BLoC',
            theme: ThemeData(
              useMaterial3: true,
            ),
            home: FutureBuilder<String?>(
              future: SharedPref().getToken(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.data != null) {
                  return BlocBuilder<NavigationCubit, NavigationState>(
                    builder: (context, navState) {
                      switch (navState) {
                        case NavigationState.profile:
                          return const ProfileScreen();
                        case NavigationState.home:
                        default:
                          return const HomeScreen();
                      }
                    },
                  );
                }
                return const LoginScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
