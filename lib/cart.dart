import 'package:flutter/material.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  int itemCount = 1;
  double totalPrice = 82.25;
  double discount = 12.25;
  double finalPrice = 70.25;

  void incrementItem() {
    setState(() {
      itemCount++;
    });
  }

  void decrementItem() {
    setState(() {
      if (itemCount > 1) {
        itemCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                cartItem("Sulphurfree Bura", "570 MI", 20.0),
                cartItem("Sulphurfree Bura", "570 MI", 20.0),
                cartItem("Sulphurfree Bura", "570 MI", 20.0),
              ],
            ),
          ),
          couponSection(),
          totalSummary(),
          checkoutButton(),
        ],
      ),
    );
  }

  Widget cartItem(String name, String size, double price) {
    return ListTile(
      leading: Image.asset(
        'assets/images/product.png', // Replace with the actual image path
        width: 50,
        height: 50,
      ),
      title: Text(name),
      subtitle: Text(size),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: decrementItem,
                icon: Icon(Icons.remove),
              ),
              Text('$itemCount'),
              IconButton(
                onPressed: incrementItem,
                icon: Icon(Icons.add),
              ),
            ],
          ),
          Text('\$$price'),
        ],
      ),
    );
  }

  Widget couponSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Entry Voucher Code',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              // Add coupon logic
            },
            child: Text('Apply'),
          ),
        ],
      ),
    );
  }

  Widget totalSummary() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          rowSummary('Total Item', '$itemCount'),
          rowSummary('Weight', '33 Kg'),
          rowSummary('Price', '\$$totalPrice'),
          rowSummary('Discount', '\$$discount'),
          Divider(),
          rowSummary('Total Price', '\$$finalPrice'),
        ],
      ),
    );
  }

  Widget rowSummary(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value),
        ],
      ),
    );
  }

  Widget checkoutButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          // Proceed to checkout
        },
        style: ElevatedButton.styleFrom(
          // primary: Colors.green,
          padding: EdgeInsets.symmetric(vertical: 16),
          minimumSize: Size(double.infinity, 50),
        ),
        child: Text('Checkout'),
      ),
    );
  }
}
