import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({Key? key}) : super(key: key); // Added Key parameter

  // list of favorite items
  final List<Map<String, String>> favoriteItems = [
    {
      'name': 'Alienware M18 R2',
      'image': 'assets/images/Alienware_M18_R2.png',
      'price': '\$3499',
    },
    {
      'name': 'ROG Strix G15 2022 G513',
      'image': 'assets/images/ROG_Strix_G15_2022_G513.png',
      'price': '\$1599',
    },
    {
      'name': 'Lenovo ThinkPad T14',
      'image': 'assets/images/Lenovo_ThinkPad_T14.png',
      'price': '\$1199',
    },
    {
      'name': 'ASUS Zenbook Pro 14 OLED',
      'image': 'assets/images/ASUS_Zenbook_Pro_14_OLED.png',
      'price': '\$1499',
    },
    {
      'name': 'Razer Blade 14 2024',
      'image': 'assets/images/Razer_Blade_14_2024.png',
      'price': '\$2299',
    },
    {
      'name': 'ROG Strix G17',
      'image': 'assets/images/ROG_Strix_G17.png',
      'price': '\$1799',
    },
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        // AppBar styling is managed by the theme
      ),
      body: favoriteItems.isEmpty
          ? Center(
        child: Text(
          'No favorites added yet!',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(10.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Determine the number of columns based on screen width
            int crossAxisCount = constraints.maxWidth < 600
                ? 2
                : constraints.maxWidth < 900
                ? 3
                : 4;

            return GridView.builder(
              itemCount: favoriteItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final item = favoriteItems[index];
                return FavoriteGridItem(
                  name: item['name']!,
                  image: item['image']!,
                  price: item['price']!,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// Reusable widget for each favorite grid item
class FavoriteGridItem extends StatelessWidget {
  final String name;
  final String image;
  final String price;

  const FavoriteGridItem({
    Key? key,
    required this.name,
    required this.image,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine card color based on theme
    final cardColor =
        Theme.of(context).cardTheme.color ?? Theme.of(context).colorScheme.surface;

    return Card(
      color: cardColor,
      elevation: Theme.of(context).cardTheme.elevation ?? 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stack to place the heart icon over the image
          Stack(
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 120,
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey[700],
                      ),
                    );
                  },
                ),
              ),
              // Heart Icon Positioned at the top-right corner
              Positioned(
                top: 8,
                right: 8,
                child: InkWell(
                  onTap: () {
                    // Remove from favorites logic (not implemented)
                  },
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.9),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Product Details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name with fixed height to enforce two lines
                SizedBox(
                  height: 40, // Adjust this height based on font size and line height
                  child: Text(
                    name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2, // Enforce two lines
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 4),
                // Product Price
                Text(
                  price,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                // Add to Cart Button aligned at the bottom
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add to cart logic (not implemented)
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      // Colors are managed by the theme's ElevatedButtonThemeData
                    ),
                    child: Text(
                      'Add to Cart',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
