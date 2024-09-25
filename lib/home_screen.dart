import 'package:flutter/material.dart';
import 'detail_screen.dart'; // Import DetailScreen

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key); // Added Key parameter

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      hintText: "Search on Tech Wizard",
                      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none, // No border by default
                      ),
                      filled: true, // Ensure the field is filled
                      fillColor: Theme.of(context).colorScheme.surface,
                    ),
                    style: Theme.of(context).textTheme.bodyLarge,
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
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          _buildCategoriesSection(context),
          // Featured Items Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: _buildSectionHeader(context, "Featured Items"),
          ),
          _buildFeaturedItemsSection(context),
          // Gaming Laptops Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: _buildSectionHeader(context, "Gaming Laptops"),
          ),
          _buildGamingLaptopsSection(context),
          // Brands Section
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Our Brands",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          _buildBrandsSection(context),
          // Laptops Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: _buildSectionHeader(context, "Laptops"),
          ),
          _buildLaptopsSection(context),
        ],
      ),
    );
  }

  // Helper to build the categories section
  Widget _buildCategoriesSection(BuildContext context) {
    List<Map<String, String>> items = [
      {
        'label': 'Laptops',
        'image': 'assets/images/Lenovo_ThinkPad_T14.png',
      },
      {
        'label': 'Gaming Laptops',
        'image': 'assets/images/ROG_Zephyrus_G16_2024.png',
      },
      {
        'label': 'All-In-One',
        'image': 'assets/images/HP_All-in-One_Desktop_Computer.jpg',
      },
      {
        'label': 'Components',
        'image': 'assets/images/intel_core_i9.png',
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
                backgroundImage: AssetImage(item['image']!),
                backgroundColor: Theme.of(context).colorScheme.surface,
              ),
              SizedBox(height: 5),
              Text(
                item['label']!,
                style: Theme.of(context).textTheme.bodyMedium,
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
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          TextButton(
            onPressed: () {
              // TODO: Implement navigation to see all items for this section
            },
            child: Text(
              "See All",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper to build the featured items section
  Widget _buildFeaturedItemsSection(BuildContext context) {
    List<Map<String, String>> featuredItems = [
      {
        'name': 'Alienware M18 R2',
        'image': 'assets/images/Alienware_M18_R2.png',
        'price': '\$3499',
      },
      {
        'name': 'Alienware X15 R1',
        'image': 'assets/images/Alienware_X15R1.png',
        'price': '\$2499',
      },
      {
        'name': 'ROG Strix G15 2022 G513',
        'image': 'assets/images/ROG_Strix_G15_2022_G513.png',
        'price': '\$1599',
      },
      {
        'name': 'ROG Zephyrus G16 2024',
        'image': 'assets/images/ROG_Zephyrus_G16_2024.png',
        'price': '\$1899',
      },
      {
        'name': 'Alienware X16 R1',
        'image': 'assets/images/Alienware_X16_R1.png',
        'price': '\$2999',
      },
      {
        'name': 'Razer Blade 14 2024',
        'image': 'assets/images/Razer_Blade_14_2024.png',
        'price': '\$2299',
      },
    ];

    return _buildHorizontalListView(context, featuredItems);
  }

  // Helper to build the gaming laptops section
  Widget _buildGamingLaptopsSection(BuildContext context) {
    List<Map<String, String>> gamingLaptops = [
      {
        'name': 'ROG Strix G17',
        'image': 'assets/images/ROG_Strix_G17.png',
        'price': '\$1799',
      },
      {
        'name': 'ASUS ROG Strix G18',
        'image': 'assets/images/ASUS_ROG_Strix_G18.png',
        'price': '\$1899',
      },
      {
        'name': 'ASUS ROG Strix G16',
        'image': 'assets/images/ASUS_ROG_Strix_G16.png',
        'price': '\$1699',
      },
      {
        'name': 'Alienware X16 R1',
        'image': 'assets/images/Alienware_X16_R1.png',
        'price': '\$2999',
      },
      {
        'name': 'Alienware M18 R2',
        'image': 'assets/images/Alienware_M18_R2.png',
        'price': '\$2599',
      },
      {
        'name': 'ROG Strix G15 2022 G513',
        'image': 'assets/images/ROG_Strix_G15_2022_G513.png',
        'price': '\$1599',
      },
    ];

    return _buildHorizontalListView(context, gamingLaptops);
  }

  // Helper to build the brands section
  Widget _buildBrandsSection(BuildContext context) {
    List<Map<String, String>> brands = [
      {
        'label': 'Lenovo',
        'image': 'assets/images/lenovo.png',
      },
      {
        'label': 'Razer',
        'image': 'assets/images/razer.png',
      },
      {
        'label': 'Asus',
        'image': 'assets/images/asus.png',
      },
      {
        'label': 'HP',
        'image': 'assets/images/hp.png',
      },
      {
        'label': 'Dell',
        'image': 'assets/images/dell.png',
      },
    ];

    return Container(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: brands.map((brand) {
          return Container(
            width: 80,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(brand['image']!),
                  backgroundColor: Theme.of(context).colorScheme.surface,
                ),
                SizedBox(height: 5),
                Text(
                  brand['label']!,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // Helper to build the laptops section
  Widget _buildLaptopsSection(BuildContext context) {
    List<Map<String, String>> laptops = [
      {
        'name': 'Lenovo ThinkPad T14',
        'image': 'assets/images/Lenovo_ThinkPad_T14.png',
        'price': '\$1199',
      },
      {
        'name': 'Lenovo Yoga 7i 2-in-1',
        'image': 'assets/images/Lenovo_Yoga_7i_2-in-1.png',
        'price': '\$999',
      },
      {
        'name': 'Lenovo Yoga 9i',
        'image': 'assets/images/Lenovo_Yoga_9i.png',
        'price': '\$1299',
      },
      {
        'name': 'Lenovo Yoga 9i 2-in-1',
        'image': 'assets/images/Lenovo_Yoga_9i_2-in-1.png',
        'price': '\$1399',
      },
      {
        'name': 'ASUS Zenbook Pro 14 OLED',
        'image': 'assets/images/ASUS_Zenbook_Pro_14_OLED.png',
        'price': '\$1499',
      },
      {
        'name': 'ROG Strix G17',
        'image': 'assets/images/ROG_Strix_G17.png',
        'price': '\$1799',
      },
    ];

    return _buildHorizontalListView(context, laptops);
  }

  // General helper to build horizontal list views
  Widget _buildHorizontalListView(BuildContext context, List<Map<String, String>> items) {
    return Container(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          double imageHeight = 150;

          // List of item names with adjusted image height
          List<String> adjustedItems = [
            'Alienware M18 R2',
            'Alienware X15 R1',
            'ROG Strix G15 2022 G513',
            'ROG Zephyrus G16 2024',
            'Alienware X16 R1',
            'Razer Blade 14 2024',
            'ROG Strix G17',
            'ASUS ROG Strix G18',
            'ASUS ROG Strix G16',
            'Razer Blade 16 2024',
            'Lenovo ThinkPad T14',
            'Lenovo Yoga 7i 2-in-1',
            'Lenovo Yoga 9i',
            'Lenovo Yoga 9i 2-in-1',
            'ASUS Zenbook Pro 14 OLED',
          ];

          if (adjustedItems.contains(item['name'])) {
            imageHeight = 120; // Adjusted height for specific items
          }

          return InkWell(
            onTap: () {
              // Navigate to the DetailScreen when tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailScreen()),
              );
            },
            child: Container(
              width: 160,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Container(
                    height: imageHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(item['image']!),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Product Name
                  Text(
                    item['name'] ?? '',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  // Product Price
                  Text(
                    item['price'] ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
