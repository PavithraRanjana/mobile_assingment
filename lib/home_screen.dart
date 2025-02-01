import 'package:flutter/material.dart';
import 'package:mobile_assingment/providers/brand_provider.dart';
import 'package:provider/provider.dart';
import 'brand_details_screen.dart';
import 'detail_screen.dart';
import '../providers/category_provider.dart';
import 'category_products_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch categories when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
      Provider.of<BrandProvider>(context, listen: false).fetchBrands();
    });
  }

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
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                    ),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),

          // Categories Section
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Product Categories",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          _buildCategoriesSection(),

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

  Widget _buildCategoriesSection() {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        if (categoryProvider.isLoading) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (categoryProvider.error != null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(categoryProvider.error!),
                ElevatedButton(
                  onPressed: () => categoryProvider.fetchCategories(),
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: categoryProvider.categories.map((category) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryProductsScreen(
                          categorySlug: category.slug,
                          categoryName: category.name,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: ClipOval(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Image.network(
                                'https://techwizard-7z3ua.ondigitalocean.app${category.image}',
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.category,
                                    size: 40,
                                    color: Theme.of(context).colorScheme.primary,
                                  );
                                },
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        width: 80,
                        child: Text(
                          category.name,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
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

  Widget _buildBrandsSection(BuildContext context) {
    return Consumer<BrandProvider>(
      builder: (context, brandProvider, child) {
        if (brandProvider.isLoading) {
          return Container(
            height: 120,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (brandProvider.error != null) {
          return Container(
            height: 120,
            child: Center(
              child: Text(
                brandProvider.error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          );
        }

        return Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: brandProvider.brands.length,
            itemBuilder: (context, index) {
              final brand = brandProvider.brands[index];
              return Container(
                width: 80,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BrandDetailsScreen(
                          brandSlug: brand.slug,
                          brandName: brand.name,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        child: ClipOval(
                          child: Image.network(
                            'https://techwizard-7z3ua.ondigitalocean.app${brand.logo}',
                            width: 80,
                            height: 80,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.business,
                                size: 40,
                                color: Theme.of(context).colorScheme.primary,
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        brand.name,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
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
        imageHeight = 120;
      }

      return InkWell(
          onTap: () {
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
    Container(
    height: imageHeight,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage(item['image']!),
    fit: BoxFit.contain,
    ),
    borderRadius: BorderRadius.circular(10),
    color: Theme.of(context).colorScheme.surface,
    ),
    ),
    SizedBox(height: 10),
    Text(
    item['name'] ?? '',
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
      SizedBox(height: 5),
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