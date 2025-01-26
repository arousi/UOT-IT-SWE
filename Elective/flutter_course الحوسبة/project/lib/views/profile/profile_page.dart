import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String? userName;

  const ProfilePage({super.key, this.userName = 'not receive'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('User is: $userName'),
            const Text('This is Profile Page'),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/settings');
                },
                child: const Text('Settings')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/home');
                },
                child: const Text('Home'))
          ],
        ),
      ),
    );
  }
}
