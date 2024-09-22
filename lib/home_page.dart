// lib/home_page.dart

import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'favorites_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(key: ValueKey('Home')),
    FavoritesScreen(key: ValueKey('Favorites')),
    CartScreen(key: ValueKey('Cart')),
    ProfileScreen(key: ValueKey('Profile')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tech Wizard'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 20, // Adjust the radius as needed
            backgroundImage: AssetImage('assets/images/wizard_1.png'),
            backgroundColor: Colors.transparent, // Optional
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
            // Icon color is managed by the AppBarTheme in the theme files
          )
        ],
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 600),
        transitionBuilder: (Widget child, Animation<double> animation) {
          // You can choose different transitions here
          return FadeTransition(child: child, opacity: animation);
        },
        child: _screens[_currentIndex],
        layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
          return Stack(
            children: <Widget>[
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex, // Use _currentIndex here
        onTap: (index) {
          if (index != _currentIndex) { // Prevent redundant state updates
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        // Colors and styles are managed by the BottomNavigationBarTheme in the theme files
      ),
    );
  }
}
