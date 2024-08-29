import 'dart:ui';
import './main.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('Main')),
    Center(child: Text('Search')),
    Center(child: Text('Profile')),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bottom Navigation Bar')),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState
    extends State<CustomBottomNavigationBar> {
  int myindex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      backgroundColor: const Color.fromARGB(255, 34, 34, 34),
      onTap: (index) {
        setState(() {
          myindex = index;
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const fav()),
            );
          }
        });
      },
      currentIndex: myindex,
      selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.new_releases_outlined),
          label: 'Latest',
          backgroundColor: const Color.fromARGB(255, 34, 34, 34),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorite',
          backgroundColor: const Color.fromARGB(255, 34, 34, 34),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_fire_department_rounded),
          label: 'Trending',
          backgroundColor: const Color.fromARGB(255, 34, 34, 34),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: 'GG',
          backgroundColor: const Color.fromARGB(255, 34, 34, 34),
        )
      ],
    );
  }
}
