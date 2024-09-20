// cart_screen.dart

import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample list of cart items
    List<Map<String, dynamic>> cartItems = [
      {
        'name': 'Alienware M18 R2',
        'image': 'assets/images/Alienware_M18_R2.jpg',
        'price': 3499.0, // Ensure price is a double
        'quantity': 1,   // Quantity as int
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        // Colors and styles are managed by the theme
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];

                // Cast quantity and price
                int quantity = item['quantity'] as int;
                double price = item['price'] as double;
                double itemTotalPrice = price * quantity;

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
                          child: Image.asset(
                            item['image'],
                            fit: BoxFit.cover,
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
                                  // Item Total Price (Moved Slightly to Left)
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
              },
            ),
          ),
          // Bottom Total Container
          Container(
            padding: EdgeInsets.all(16.0),
            color: Theme.of(context).colorScheme.background.withOpacity(0.1),
            child: Column(
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
