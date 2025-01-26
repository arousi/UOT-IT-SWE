import 'package:flutter/material.dart';

import '../../widgets/side_bar/app_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: 1000,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 5),
            height: 100,
            color: index.isOdd ? Colors.red : Colors.green,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (value) {
          currentIndex = value;

          setState(() {});
        },
      ),
    );
  }
}
