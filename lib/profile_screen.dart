// lib/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';
import 'providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  final String userImage = 'assets/images/profile_pic.png';

  @override
  Widget build(BuildContext context) {
    // List of profile options remains the same
    final List<Map<String, dynamic>> profileOptions = [
      {
        'icon': Icons.person,
        'label': 'Profile',
        'onTap': () {
          // Navigate to Profile Details
        },
      },
      {
        'icon': Icons.home,
        'label': 'Address',
        'onTap': () {
          // Navigate to Address Details
        },
      },
      {
        'icon': Icons.shopping_bag,
        'label': 'Past Orders',
        'onTap': () {
          // Navigate to Past Orders
        },
      },
      {
        'icon': Icons.favorite,
        'label': 'Favorites',
        'onTap': () {
          // Navigate to Favorites
        },
      },
      {
        'icon': Icons.payment,
        'label': 'Payment Info',
        'onTap': () {
          // Navigate to Payment Info
        },
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              // User's Name and Image Section
              Container(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                width: double.infinity,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // User Profile Picture
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(userImage),
                      backgroundColor: Colors.grey[200],
                      onBackgroundImageError: (_, __) {
                        // Handle image loading errors
                      },
                    ),
                    SizedBox(height: 20),
                    // User Name - Show only if authenticated
                    if (auth.isAuthenticated)
                      Text(
                        auth.userName ?? 'User Name',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Profile Options Section - Show only if authenticated
              if (auth.isAuthenticated)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: profileOptions.map((option) {
                      return ProfileOption(
                        icon: option['icon'],
                        label: option['label'],
                        onTap: option['onTap'],
                      );
                    }).toList(),
                  ),
                ),
              SizedBox(height: 30),
              // Action Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: auth.isAuthenticated
                            ? null // Disable button if authenticated
                            : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Sign In',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Conditional button: Logout for authenticated users, Create Account for unauthenticated
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          if (auth.isAuthenticated) {
                            auth.logout();
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            );
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          auth.isAuthenticated ? 'Logout' : 'Create Account',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
            ],
          );
        },
      ),
    );
  }
}

// Reusable widget for Profile Options
class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ProfileOption({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
        size: 28,
      ),
      title: Text(
        label,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: 16,
      ),
      onTap: onTap,
    );
  }
}