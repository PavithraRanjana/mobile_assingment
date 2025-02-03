// lib/providers/cart_provider.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartItem {
  final String productId;
  final String variantId;
  final int quantity;
  final String price;
  final String name;
  final String image;

  CartItem({
    required this.productId,
    required this.variantId,
    required this.quantity,
    required this.price,
    required this.name,
    required this.image,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['product_id'],
      variantId: json['variant_id'],
      quantity: json['quantity'],
      price: json['price'],
      name: json['name'],
      image: json['image'],
    );
  }

  double get priceAsDouble => double.parse(price);
  double get totalPrice => priceAsDouble * quantity;
}

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  double _total = 0.0;  // Changed from String to double
  int _count = 0;
  bool _isLoading = false;
  String? _error;
  Map<String, bool> _loadingItems = {};

  // Getters
  List<CartItem> get items => _items;
  double get total => _total;  // Changed return type to double
  int get count => _count;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool isItemLoading(String productId) => _loadingItems[productId] ?? false;

  // Fetch cart items
  Future<void> fetchCart(String token) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://techwizard-7z3ua.ondigitalocean.app/api/cart'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _items = (data['items'] as List)
            .map((item) => CartItem.fromJson(item))
            .toList();
        _total = double.parse(data['total'].toString());  // Parse as double
        _count = data['count'];
        _error = null;
      } else {
        _error = 'Failed to load cart';
      }
    } catch (e) {
      _error = 'Network error occurred';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  // Update cart item quantity
  Future<bool> updateQuantity(String productId, String variantId, int quantity, String token) async {
    _loadingItems[productId] = true;
    notifyListeners();

    try {
      final response = await http.put(
        Uri.parse('https://techwizard-7z3ua.ondigitalocean.app/api/cart/update'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'product_id': productId,
          'variant_id': variantId,
          'quantity': quantity,
        }),
      );

      if (response.statusCode == 200) {
        await fetchCart(token);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    } finally {
      _loadingItems[productId] = false;
      notifyListeners();
    }
  }

  // Remove item from cart
  Future<bool> removeItem(String productId, String variantId, String token) async {
    _loadingItems[productId] = true;
    notifyListeners();

    try {
      final response = await http.delete(
        Uri.parse('https://techwizard-7z3ua.ondigitalocean.app/api/cart/remove'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'product_id': productId,
          'variant_id': variantId,
        }),
      );

      if (response.statusCode == 200) {
        await fetchCart(token);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    } finally {
      _loadingItems[productId] = false;
      notifyListeners();
    }
  }

  // Add to cart
// In CartProvider class

  Future<bool> addToCart(String productId, String? variantId, String token) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Create the request body
      Map<String, dynamic> requestBody = {
        "product_id": productId,
        "quantity": 1,
      };

      // Only add variant_id if it's provided
      if (variantId != null && variantId.isNotEmpty) {
        requestBody["variant_id"] = variantId;
      }

      print('Request body: ${jsonEncode(requestBody)}');

      final response = await http.post(
        Uri.parse('https://techwizard-7z3ua.ondigitalocean.app/api/cart/add'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchCart(token);
        return true;
      }
      return false;
    } catch (e) {
      print('Cart Error: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearCart() {
    _items = [];
    _total = 0.0;  // Reset to 0.0 instead of String
    _count = 0;
    _loadingItems = {};
    _error = null;
    notifyListeners();
  }
}