// lib/cart_screen.dart

import 'package:flutter/material.dart';
import 'dart:math'; // For min function

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key); // Added Key parameter

  @override
  Widget build(BuildContext context) {
    // Sample list of cart items
    List<Map<String, dynamic>> cartItems = [
      {
        'name': 'Alienware M18 R2',
        'image': 'assets/images/Alienware_M18_R2.png',
        'price': 3499.0,
        'quantity': 1,
      },
      {
        'name': 'ROG Zephyrus G16 2024',
        'image': 'assets/images/ROG_Zephyrus_G16_2024.png',
        'price': 1899.0,
        'quantity': 2,
      },
      // Third item added here
      {
        'name': 'Lenovo ThinkPad T14',
        'image': 'assets/images/Lenovo_ThinkPad_T14.png',
        'price': 1199.0,
        'quantity': 1,
      },
    ];

    // Initialize totals as num to accommodate both int and double
    num totalItems = 0;
    num totalPrice = 0;

    for (var item in cartItems) {
      // Explicitly cast quantity and price to int and double
      int quantity = item['quantity'] as int;
      double price = item['price'] as double;

      totalItems += quantity;
      totalPrice += price * quantity;
    }

    // Retrieve orientation
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true, // Centers the AppBar title
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      body: orientation == Orientation.portrait
          ? _buildPortraitLayout(context, cartItems, totalItems, totalPrice)
          : _buildLandscapeLayout(context, cartItems, totalItems, totalPrice),
    );
  }

  // Portrait Mode Layout: Vertical List of Cart Items
  Widget _buildPortraitLayout(BuildContext context, List<Map<String, dynamic>> cartItems,
      num totalItems, num totalPrice) {
    return ListView.builder(
      itemCount: cartItems.length + 1, // Additional item for the bottom section
      itemBuilder: (context, index) {
        if (index < cartItems.length) {
          final item = cartItems[index];

          // Cast quantity and price
          int quantity = item['quantity'] as int;
          double price = item['price'] as double;
          double itemTotalPrice = price * quantity;

          return _buildPortraitCartItem(context, item, quantity, itemTotalPrice);
        } else {
          // Bottom Total Container
          return _buildTotalContainer(context, totalItems, totalPrice);
        }
      },
    );
  }

  // Landscape Mode Layout: Grid with 3 Items per Row
  Widget _buildLandscapeLayout(BuildContext context, List<Map<String, dynamic>> cartItems,
      num totalItems, num totalPrice) {
    // Calculate the number of rows needed (3 items per row)
    int numRows = (cartItems.length / 3).ceil();

    return ListView.builder(
      itemCount: numRows + 1, // Additional item for the bottom section
      itemBuilder: (context, index) {
        if (index < numRows) {
          // Determine the start and end indices for the current row
          int startIndex = index * 3;
          int endIndex = min(startIndex + 3, cartItems.length);
          List<Map<String, dynamic>> rowItems = cartItems.sublist(startIndex, endIndex);

          return _buildLandscapeCartRow(context, rowItems);
        } else {
          // Bottom Total Container
          return _buildTotalContainer(context, totalItems, totalPrice);
        }
      },
    );
  }

  // Portrait Mode Cart Item Widget
  Widget _buildPortraitCartItem(BuildContext context, Map<String, dynamic> item, int quantity,
      double itemTotalPrice) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Item Image (Scaled Down)
            Container(
              width: 50, // Scaled down width
              height: 50, // Scaled down height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage(item['image']),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: 10),
            // Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Item Name
                  Text(
                    item['name'],
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  // Quantity Controls and Price
                  Row(
                    children: [
                      // Decrease Quantity Button
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          // Decrease quantity logic (not implemented)
                        },
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      // Quantity Text
                      Text(
                        '$quantity',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      // Increase Quantity Button
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: () {
                          // Increase quantity logic (not implemented)
                        },
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(width: 15), // Adjusted spacing
                      // Item Total Price
                      Text(
                        '\$${itemTotalPrice.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Delete Button
            IconButton(
              icon: Icon(Icons.delete_outline),
              onPressed: () {
                // Delete item logic (not implemented)
              },
              color: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }

  // Landscape Mode Cart Row Widget: Contains up to 3 Cart Items Side by Side
  Widget _buildLandscapeCartRow(BuildContext context, List<Map<String, dynamic>> rowItems) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: rowItems.map((item) {
          // Cast quantity and price
          int quantity = item['quantity'] as int;
          double price = item['price'] as double;
          double itemTotalPrice = price * quantity;

          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      // Item Image (Spanning Full Width)
                      Container(
                        width: double.infinity, // Makes image width as much as card's width
                        height: 120, // Adjusted height accordingly
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage(item['image']),
                            fit: BoxFit.contain, // Use BoxFit.contain
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Item Name
                      Text(
                        item['name'],
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      // Quantity Controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Decrease Quantity Button
                          IconButton(
                            icon: Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              // Decrease quantity logic (not implemented)
                            },
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          // Quantity Text
                          Text(
                            '$quantity',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          // Increase Quantity Button
                          IconButton(
                            icon: Icon(Icons.add_circle_outline),
                            onPressed: () {
                              // Increase quantity logic (not implemented)
                            },
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      // Delete Button
                      IconButton(
                        icon: Icon(Icons.delete_outline),
                        onPressed: () {
                          // Delete item logic (not implemented)
                        },
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      SizedBox(height: 5),
                      // Item Total Price
                      Text(
                        '\$${itemTotalPrice.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Bottom Total Container Widget
  Widget _buildTotalContainer(BuildContext context, num totalItems, num totalPrice) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Theme.of(context).colorScheme.background.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Total Number of Items
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total number of items:',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$totalItems',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          SizedBox(height: 5),
          // Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price:',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${totalPrice.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          SizedBox(height: 5),
          // Total Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Price:',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${totalPrice.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          SizedBox(height: 10),
          // Checkout Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Checkout logic (not implemented)
              },
              child: Text('Checkout'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                // Colors are managed by the theme's ElevatedButtonThemeData
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable widget for Specification Items
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
