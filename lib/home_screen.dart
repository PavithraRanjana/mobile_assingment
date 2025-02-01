import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/brand_provider.dart';
import '../providers/category_provider.dart';
import 'brand_details_screen.dart';
import 'detail_screen.dart';
import 'category_products_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic>? laptopProducts;
  bool isLoadingLaptops = false;
  String? laptopError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
      Provider.of<BrandProvider>(context, listen: false).fetchBrands();
      _fetchLaptops();
    });
  }

  Future<void> _fetchLaptops() async {
    setState(() {
      isLoadingLaptops = true;
      laptopError = null;
    });

    try {
      final categoryProvider =
          Provider.of<CategoryProvider>(context, listen: false);
      final category = await categoryProvider.fetchCategoryBySlug('laptops');

      if (category != null) {
        setState(() {
          laptopProducts = categoryProvider.categoryProducts?.take(6).toList();
          isLoadingLaptops = false;
        });
      } else {
        setState(() {
          laptopError = 'Failed to load laptops';
          isLoadingLaptops = false;
        });
      }
    } catch (e) {
      setState(() {
        laptopError = 'Error loading laptops';
        isLoadingLaptops = false;
      });
    }
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
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium?.copyWith(
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

          // Laptops Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: _buildSectionHeader(context, "Laptops",
                categorySlug: 'laptops'),
          ),
          _buildLaptopsSection(context),

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
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  );
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
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

  Widget _buildSectionHeader(BuildContext context, String title,
      {String? categorySlug}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          TextButton(
            onPressed: categorySlug != null
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryProductsScreen(
                          categorySlug: categorySlug,
                          categoryName: title,
                        ),
                      ),
                    );
                  }
                : null,
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

  Widget _buildLaptopsSection(BuildContext context) {
    if (isLoadingLaptops) {
      return Container(
        height: 250,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (laptopError != null) {
      return Container(
        height: 250,
        child: Center(
          child: Text(laptopError!),
        ),
      );
    }

    if (laptopProducts == null || laptopProducts!.isEmpty) {
      return Container(
        height: 250,
        child: Center(
          child: Text('No laptops available'),
        ),
      );
    }

    return Container(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: laptopProducts!.length,
        itemBuilder: (context, index) {
          final product = laptopProducts![index];
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
                    height: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://techwizard-7z3ua.ondigitalocean.app${product['images']['primary']}',
                        ),
                        fit: BoxFit.contain,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    product['name'] ?? '',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    '\$${_getDefaultPrice(product['variants'])}',
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
    return Consumer<BrandProvider>(builder: (context, brandProvider, child) {
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
    });
  }

  Widget _buildHorizontalListView(
      BuildContext context, List<Map<String, String>> items) {
    return Container(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          double imageHeight = 150;

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

  String _getDefaultPrice(List<dynamic> variants) {
    final defaultVariant = variants.firstWhere(
      (variant) => variant['is_default'] == true,
      orElse: () => variants.first,
    );
    return defaultVariant['price']['current'];
  }
}
