import 'dart:developer';

import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Page'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('This is Settings Page'),
            ElevatedButton(
                onPressed: () {
                  if (Navigator.of(context).canPop()) {
                    //guard to leave?
                    log('yes');
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('Can you go backwarD?'))
          ],
        ),
      ),
    );
  }
}
