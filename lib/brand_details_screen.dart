// lib/screens/brand_details_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/brand_provider.dart';
import 'detail_screen.dart';

class BrandDetailsScreen extends StatefulWidget {
  final String brandSlug;
  final String brandName;

  const BrandDetailsScreen({
    Key? key,
    required this.brandSlug,
    required this.brandName,
  }) : super(key: key);

  @override
  _BrandDetailsScreenState createState() => _BrandDetailsScreenState();
}

class _BrandDetailsScreenState extends State<BrandDetailsScreen> {
  bool isLoading = true;
  Map<String, List<dynamic>>? categoryProducts;
  String? error;
  Map<String, dynamic>? brandDetails;

  @override
  void initState() {
    super.initState();
    _loadBrandDetails();
  }

  Future<void> _loadBrandDetails() async {
    final brandProvider = Provider.of<BrandProvider>(context, listen: false);
    setState(() => isLoading = true);

    try {
      final details = await brandProvider.fetchBrandDetails(widget.brandSlug);
      setState(() {
        brandDetails = details['brand'];
        categoryProducts = _organizeProductsByCategory(details['products']);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  Map<String, List<dynamic>> _organizeProductsByCategory(Map<String, dynamic> productsData) {
    Map<String, List<dynamic>> organized = {};

    // Category ID to name mapping
    final Map<String, String> categoryIds = {
      '678c42fa0ba029e32f071dab': 'Laptops',
      '678c43440ba029e32f071dac': 'Desktops',
      '678c439cd0cfe358380cbcc4': 'Accessories',
      '678c4410d0cfe358380cbcc5': 'Gaming Laptops',
    };

    // Access the 'data' array inside the products map
    final List<dynamic> products = productsData['data'];

    for (var product in products) {
      final categoryId = product['category']['\$id'];
      final categoryName = categoryIds[categoryId] ?? 'Other';

      if (!organized.containsKey(categoryName)) {
        organized[categoryName] = [];
      }
      organized[categoryName]!.add(product);
    }

    return organized;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.brandName),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : error != null
          ? Center(child: Text(error!))
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (brandDetails != null) _buildBrandHeader(context),
            ..._buildCategorySections(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Brand Logo
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            padding: EdgeInsets.all(16),
            child: Image.network(
              'https://techwizard-7z3ua.ondigitalocean.app${brandDetails!['logo']['primary']}',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 16),
          // Brand Name
          Text(
            brandDetails!['name'],
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          // Brand Description
          Text(
            brandDetails!['description'],
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCategorySections(BuildContext context) {
    if (categoryProducts == null) return [];

    return categoryProducts!.entries.map((entry) {
      final categoryName = entry.key;
      final products = entry.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              categoryName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final product = products[index];
                return _buildProductCard(context, product);
              },
            ),
          ),
        ],
      );
    }).toList();
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              productSlug: product['slug'],
            ),
          ),
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://techwizard-7z3ua.ondigitalocean.app${product['images']['primary']}',
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
                      product['name'],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    // Price
                    Text(
                      '\$${_getDefaultPrice(product['variants'])}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    // Base Configuration Summary
                    // Text(
                    //   '${product['base_configuration']['processor']} • ${product['base_configuration']['RAM']} RAM',
                    //   style: Theme.of(context).textTheme.bodySmall,
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
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