import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.sizeOf(context).width * .6,
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.of(context).pushNamed('/settings');
              },
            ),
            ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.of(context).pushNamed('Profile', arguments: 'Omar');
              },
            ),
          ],
        ),
      ),
    );
  }
}
