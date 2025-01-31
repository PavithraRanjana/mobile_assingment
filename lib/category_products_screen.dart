// lib/screens/category_products_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../providers/category_provider.dart';
import 'detail_screen.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String categorySlug;
  final String categoryName;

  const CategoryProductsScreen({
    Key? key,
    required this.categorySlug,
    required this.categoryName,
  }) : super(key: key);

  @override
  _CategoryProductsScreenState createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  Category? category;
  List<Product>? products;
  bool isLoading = true;

  // Map of brand IDs to their names
  final Map<String, String> brandNames = {
    '678c4538d84a99f6840fa409': 'ASUS',
    '678c467dd84a99f6840fa40a': 'Alienware',
    '678c46f738f095549c05ef38': 'Lenovo',
    '678c4772d0cfe358380cbcc6': 'Razer Inc.',
    '678c47ce0ba029e32f071dad': 'Apple',
  };

  @override
  void initState() {
    super.initState();
    _loadCategory();
  }

  Future<void> _loadCategory() async {
    final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    setState(() => isLoading = true);
    category = await categoryProvider.fetchCategoryBySlug(widget.categorySlug);
    if (category != null && mounted) {
      final productsData = categoryProvider.categoryProducts;
      if (productsData != null) {
        products = productsData.map((product) => Product.fromJson(product)).toList();
      }
    }
    setState(() => isLoading = false);
  }

  Map<String, List<Product>> _groupProductsByBrand() {
    if (products == null) return {};

    Map<String, List<Product>> groupedProducts = {};
    for (var product in products!) {
      final brandId = product.brandId;
      if (!groupedProducts.containsKey(brandId)) {
        groupedProducts[brandId] = [];
      }
      groupedProducts[brandId]!.add(product);
    }
    return groupedProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : category == null
          ? Center(child: Text('Failed to load category'))
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Image
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://techwizard-7z3ua.ondigitalocean.app${category!.image}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Description
                  Text(
                    category!.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 20),

                  // Products by Brand
                  ..._buildBrandSections(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBrandSections() {
    final groupedProducts = _groupProductsByBrand();

    return groupedProducts.entries.map((entry) {
      // Get brand name from the map, fallback to brandId if not found
      final brandName = brandNames[entry.key] ?? 'Brand ${entry.key}';

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              brandName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 260, // Reduced height to prevent overflow
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: entry.value.length,
              itemBuilder: (context, index) {
                final product = entry.value[index];
                return _buildProductCard(product);
              },
            ),
          ),
          SizedBox(height: 16),
        ],
      );
    }).toList();
  }

  Widget _buildProductCard(Product product) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen()),
        );
      },
      child: Container(
        width: 200,
        margin: EdgeInsets.only(right: 16),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://techwizard-7z3ua.ondigitalocean.app${product.images['primary']}',
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    // Price
                    Text(
                      '\$${product.defaultPrice}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}