// lib/profile_screen.dart

import 'package:flutter/material.dart';
import 'sign_in_screen.dart'; // Import the Sign-In Screen

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key); // Added Key parameter

  final String userName = 'Pavithra Dissanayaka';
  final String userImage = 'assets/images/profile_pic.png';

  @override
  Widget build(BuildContext context) {
    // Sample list of profile options
    final List<Map<String, dynamic>> profileOptions = [
      {
        'icon': Icons.person,
        'label': 'Profile',
        'onTap': () {
          // Navigate to Profile Details (Functionality will be implemented in 2nd sem)
        },
      },
      {
        'icon': Icons.home,
        'label': 'Address',
        'onTap': () {
          // Navigate to Address Details (Functionality will be implemented in 2nd sem)
        },
      },
      {
        'icon': Icons.shopping_bag,
        'label': 'Past Orders',
        'onTap': () {
          // Navigate to Past Orders (Functionality will be implemented in 2nd sem)
        },
      },
      {
        'icon': Icons.favorite,
        'label': 'Favorites',
        'onTap': () {
          // Navigate to Favorites (Functionality will be implemented in 2nd sem)
        },
      },
      {
        'icon': Icons.payment,
        'label': 'Payment Info',
        'onTap': () {
          // Navigate to Payment Info (Functionality will be implemented in 2nd sem)
        },
      },
    ];

    // Retrieve orientation
    final Orientation orientation = MediaQuery.of(context).orientation;

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
          // Profile Options Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: orientation == Orientation.portrait
                ? Column(
              children: profileOptions.map((option) {
                return ProfileOption(
                  icon: option['icon'],
                  label: option['label'],
                  onTap: option['onTap'],
                );
              }).toList(),
            )
                : _buildLandscapeProfileOptions(context, profileOptions),
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
                      // Logout logic (Functionality will be implemented in 2nd sem)
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

  // Portrait Mode: Builds a Column of ProfileOptions
  Widget _buildPortraitProfileOptions(
      BuildContext context, List<Map<String, dynamic>> profileOptions) {
    return Column(
      children: profileOptions.map((option) {
        return ProfileOption(
          icon: option['icon'],
          label: option['label'],
          onTap: option['onTap'],
        );
      }).toList(),
    );
  }

  // Landscape Mode: Builds a Grid of ProfileOptions with 3 items per row
  Widget _buildLandscapeProfileOptions(
      BuildContext context, List<Map<String, dynamic>> profileOptions) {
    return GridView.builder(
      shrinkWrap: true, // Important to prevent unbounded height error
      physics: NeverScrollableScrollPhysics(), // Prevent GridView from scrolling separately
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 items per row
        crossAxisSpacing: 10.0, // Decreased from 10.0 to 5.0
        mainAxisSpacing: 10.0, // Decreased from 10.0 to 5.0
        childAspectRatio: 3.0, // Adjust as needed
      ),
      itemCount: profileOptions.length,
      itemBuilder: (context, index) {
        final option = profileOptions[index];
        return ProfileGridItem(
          icon: option['icon'],
          label: option['label'],
          onTap: option['onTap'],
        );
      },
    );
  }
}

// Reusable widget for Profile Options in Portrait Mode
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

// Reusable widget for Profile Options in Landscape Mode (Grid Items)
class ProfileGridItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ProfileGridItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // Decreased internal padding by reducing SizedBox heights and icon size
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 36, // Decreased from 36 to 32
            ),
            SizedBox(height: 4), // Decreased from 8 to 4
            // Label
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
