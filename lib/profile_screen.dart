// lib/profile_screen.dart

import 'package:flutter/material.dart';
import 'sign_in_screen.dart'; // Import the Sign-In Screen

class ProfileScreen extends StatelessWidget {
  final String userName = 'Pavithra Dissanayaka';
  final String userImage = 'assets/images/profile_pic.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        // AppBar styling is managed by the theme
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // User's Name and Image Section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40.0), // Added vertical padding for spacing
            width: double.infinity,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1), // Background color from theme
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
                // User Name
                Text(
                  userName,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Profile Options
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                ProfileOption(
                  icon: Icons.person,
                  label: 'Profile',
                  onTap: () {
                    // Navigate to Profile Details (Functionality will do in 2nd sem)
                  },
                ),
                ProfileOption(
                  icon: Icons.home,
                  label: 'Address',
                  onTap: () {
                    // Navigate to Address Details (Functionality will do in 2nd sem)
                  },
                ),
                ProfileOption(
                  icon: Icons.shopping_bag,
                  label: 'Past Orders',
                  onTap: () {
                    // Navigate to Past Orders (Functionality will do in 2nd sem)
                  },
                ),
                ProfileOption(
                  icon: Icons.favorite,
                  label: 'Favorites',
                  onTap: () {
                    // Navigate to Favorites (Functionality will do in 2nd sem)
                  },
                ),
                ProfileOption(
                  icon: Icons.payment,
                  label: 'Payment Info',
                  onTap: () {
                    // Navigate to Payment Info (Functionality will do in 2nd sem)
                  },
                ),
              ],
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
                    onPressed: () {
                      // Navigate to Sign-In Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      // Colors are managed by the theme's ElevatedButtonThemeData
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
                // Logout Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      // Logout logic (Functionality will do in 2nd sem)
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
                      'Logout',
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
          SizedBox(height: 30), // Extra spacing at the bottom
        ],
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
