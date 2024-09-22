// lib/detail_screen.dart

import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  // Hardcoded product details
  final String productImage = 'assets/images/Alienware_M18_R2.jpg';
  final String productName = 'Alienware M18 R2';
  final double productPrice = 3499.99;
  final String description =
      'COMMANDING POWER & PRESENCE: Outplay your rivals and show them who\'s '
      'boss with an 18-inch gaming laptop featuring 14th Gen '
      'Intel Core i9-14900HX processor and NVIDIA GeForce RTX 4080 12 GB GDDR6 '
      'graphics. Play your most demanding games with up to 270W Total Power '
      'Performance* with more headroom to support overclocking without '
      'throttling.';
  final Map<String, String> specifications = {
    'Processor': 'Intel Core i9-11900K',
    'GPU': 'NVIDIA GeForce RTX 4090',
    'RAM': '32GB DDR4',
    'SSD': '1TB NVMe',
    'Screen Size': '18-inch QHD',
    'Brand': 'Alienware',
    'Category': 'Gaming Laptop',
  };

  DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define the price color consistent with other screens
    final priceColor = Theme.of(context).colorScheme.tertiary;

    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with Favorite Icon Overlay
            Stack(
              children: [
                // Product Image
                Image.asset(
                  productImage,
                  width: double.infinity,
                  height: 300, // Adjust the height as needed
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 300,
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.image_not_supported,
                        size: 100,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
                // Favorite Icon
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: GestureDetector(
                    onTap: () {
                      // Future: Add functionality to add item to favorites
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.7),
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Product Details Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    productName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Price
                  Text(
                    '\$${productPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: priceColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Buy Now and Add to Cart Buttons
                  Row(
                    children: [
                      // Buy Now Button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Implement Buy Now functionality
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Buy Now',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      // Add to Cart Button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Implement Add to Cart functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Theme.of(context).colorScheme.secondary, // Uses theme's secondary color
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  // Product Specifications
                  Text(
                    'Specifications',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Specifications List
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: specifications.entries.map((entry) {
                      return SpecificationItem(
                        title: entry.key,
                        value: entry.value,
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 24),
                  // Description
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// SpecificationItem Widget for displaying key-value pairs
class SpecificationItem extends StatelessWidget {
  final String title;
  final String value;

  const SpecificationItem({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          // Specification Title
          Expanded(
            flex: 2,
            child: Text(
              '$title:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Specification Value
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
