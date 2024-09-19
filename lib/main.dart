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
        title: Text('eBay Clone', style: TextStyle(color: Colors.black)),
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
              child: _buildSectionHeader(context, "Featured Items"),
            ),
            _buildFeaturedItemsSection(),
            // Gaming Laptops Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: _buildSectionHeader(context, "Gaming Laptops"),
            ),
            _buildGamingLaptopsSection(),
            // Brands Section
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Our Brands",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            _buildBrandsSection(),
            // Laptops Section (Moved After Brands Section)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: _buildSectionHeader(context, "Laptops"),
            ),
            _buildLaptopsSection(),
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

  // Helper to build section headers with "See All" button
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          TextButton(
            onPressed: () {
              // Navigate to the full list of items for this section
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

    return _buildHorizontalListView(featuredItems);
  }

  // Helper to build the gaming laptops section
  Widget _buildGamingLaptopsSection() {
    List<Map<String, String>> gamingLaptops = [
      {
        'name': 'Alienware M15',
        'image': 'https://example.com/alienware_m15.png',
        'price': '\$1799',
      },
      {
        'name': 'Razer Blade 15',
        'image': 'https://example.com/razer_blade_15.png',
        'price': '\$1999',
      },
      {
        'name': 'ASUS ROG Zephyrus',
        'image': 'https://example.com/asus_rog_zephyrus.png',
        'price': '\$1599',
      },
      {
        'name': 'MSI GS66 Stealth',
        'image': 'https://example.com/msi_gs66_stealth.png',
        'price': '\$1499',
      },
      {
        'name': 'Acer Predator Helios',
        'image': 'https://example.com/acer_predator_helios.png',
        'price': '\$1299',
      },
      {
        'name': 'Lenovo Legion 5',
        'image': 'https://example.com/lenovo_legion_5.png',
        'price': '\$1099',
      },
    ];

    return _buildHorizontalListView(gamingLaptops);
  }

  // Helper to build the brands section
  Widget _buildBrandsSection() {
    List<Map<String, String>> brands = [
      {
        'label': 'Lenovo',
        'image': 'https://example.com/lenovo_logo.png',
      },
      {
        'label': 'Razer',
        'image': 'https://example.com/razer_logo.png',
      },
      {
        'label': 'Asus',
        'image': 'https://example.com/asus_logo.png',
      },
      {
        'label': 'HP',
        'image': 'https://example.com/hp_logo.png',
      },
      {
        'label': 'Dell',
        'image': 'https://example.com/dell_logo.png',
      },
    ];

    return Container(
      height: 120, // Adjust the height as needed
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: brands.map((brand) {
          return Container(
            width: 80, // Adjust the width as needed
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(brand['image']!),
                ),
                SizedBox(height: 5),
                Text(
                  brand['label']!,
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // Helper to build the laptops section (Moved After Brands Section)
  Widget _buildLaptopsSection() {
    List<Map<String, String>> laptops = [
      {
        'name': 'Dell XPS 13',
        'image': 'https://example.com/dell_xps_13.png',
        'price': '\$999',
      },
      {
        'name': 'MacBook Air',
        'image': 'https://example.com/macbook_air.png',
        'price': '\$1099',
      },
      {
        'name': 'HP Spectre x360',
        'image': 'https://example.com/hp_spectre_x360.png',
        'price': '\$1199',
      },
      {
        'name': 'Lenovo ThinkPad X1',
        'image': 'https://example.com/lenovo_thinkpad_x1.png',
        'price': '\$1299',
      },
      {
        'name': 'Asus ZenBook 14',
        'image': 'https://example.com/asus_zenbook_14.png',
        'price': '\$899',
      },
      {
        'name': 'Microsoft Surface Laptop',
        'image': 'https://example.com/surface_laptop.png',
        'price': '\$999',
      },
    ];

    return _buildHorizontalListView(laptops);
  }

  // General helper to build horizontal list views
  Widget _buildHorizontalListView(List<Map<String, String>> items) {
    return Container(
      height: 250, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
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
