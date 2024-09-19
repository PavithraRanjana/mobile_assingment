import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EbayHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class EbayHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/a/a6/Ebay_logo.png'), // eBay logo
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search on eBay",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Product Categories Section
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Product Categories",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            _buildCategoriesSection(),
            // Featured Items Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: _buildFeaturedItemsHeader(context),
            ),
            _buildFeaturedItemsSection(),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (index) {},
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
      ),
    );
  }

  // Helper to build the categories section
  Widget _buildCategoriesSection() {
    List<Map<String, String>> items = [
      {
        'label': 'Laptops',
        'image': 'https://example.com/laptops_image.png',
      },
      {
        'label': 'Gaming Laptops',
        'image': 'https://example.com/gaming_laptops_image.png',
      },
      {
        'label': 'All-In-One',
        'image': 'https://example.com/all_in_one_image.png',
      },
      {
        'label': 'Components',
        'image': 'https://example.com/components_image.png',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: items.map((item) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(item['image']!),
              ),
              SizedBox(height: 5),
              Text(
                item['label']!,
                style: TextStyle(fontSize: 14),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  // Helper to build the featured items header with "See All" button
  Widget _buildFeaturedItemsHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Featured Items",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          TextButton(
            onPressed: () {
              // Navigate to the full list of featured items
            },
            child: Text("See All"),
          ),
        ],
      ),
    );
  }

  // Helper to build the featured items section
  Widget _buildFeaturedItemsSection() {
    List<Map<String, String>> featuredItems = [
      {
        'name': 'MacBook Pro',
        'image': 'https://example.com/macbook_pro.png',
        'price': '\$1299',
      },
      {
        'name': 'Gaming PC',
        'image': 'https://example.com/gaming_pc.png',
        'price': '\$999',
      },
      {
        'name': 'Graphics Card',
        'image': 'https://example.com/graphics_card.png',
        'price': '\$499',
      },
      {
        'name': 'Mechanical Keyboard',
        'image': 'https://example.com/mechanical_keyboard.png',
        'price': '\$199',
      },
      {
        'name': 'Gaming Monitor',
        'image': 'https://example.com/gaming_monitor.png',
        'price': '\$299',
      },
      {
        'name': 'Wireless Mouse',
        'image': 'https://example.com/wireless_mouse.png',
        'price': '\$49',
      },
    ];

    return Container(
      height: 250, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: featuredItems.length,
        itemBuilder: (context, index) {
          final item = featuredItems[index];
          return Container(
            width: 160,
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(item['image']!),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 10),
                // Product Name
                Text(
                  item['name']!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                // Product Price
                Text(
                  item['price']!,
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
