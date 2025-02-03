// lib/providers/favorites_provider.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'auth_provider.dart';

class FavoriteItem {
  final String id;
  final String productId;
  final String productName;
  final String productSlug;
  final String productImage;
  final String price;
  final bool inStock;
  final DateTime addedAt;

  FavoriteItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productSlug,
    required this.productImage,
    required this.price,
    required this.inStock,
    required this.addedAt,
  });

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      id: json['id'],
      productId: json['product']['id'],
      productName: json['product']['name'],
      productSlug: json['product']['slug'],
      productImage: json['product']['image'],
      price: json['product']['price'],
      inStock: json['product']['in_stock'],
      addedAt: DateTime.parse(json['added_at']),
    );
  }
}

class FavoritesProvider with ChangeNotifier {
  List<FavoriteItem> _favorites = [];
  bool _isLoading = false;
  String? _error;

  // Track loading state for individual products
  Map<String, bool> _productLoadingStates = {};

  // Getters
  List<FavoriteItem> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Check if a specific product is loading
  bool isProductLoading(String productId) => _productLoadingStates[productId] ?? false;

  Future<void> fetchFavorites(String? token) async {
    if (token == null) {
      _favorites = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://techwizard-7z3ua.ondigitalocean.app/api/wishlist'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == true) {
          _favorites = (data['data'] as List)
              .map((item) => FavoriteItem.fromJson(item))
              .toList();
          _error = null;
        } else {
          _error = 'Failed to load favorites';
        }
      } else {
        _error = 'Failed to load favorites';
      }
    } catch (e) {
      print('Error fetching favorites: $e');
      _error = 'Network error occurred';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addToFavorites(String productId, String? token) async {
    if (token == null) return false;

    _productLoadingStates[productId] = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('https://techwizard-7z3ua.ondigitalocean.app/api/wishlist/add'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'product_id': productId,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == true) {
          // Create a temporary FavoriteItem for immediate UI update
          final tempFavoriteItem = FavoriteItem(
            id: DateTime.now().toString(), // Temporary ID
            productId: productId,
            productName: "", // These details will be updated when fetchFavorites is called
            productSlug: "",
            productImage: "",
            price: "",
            inStock: true,
            addedAt: DateTime.now(),
          );

          // Add to local list immediately
          _favorites.add(tempFavoriteItem);
          notifyListeners();

          // Fetch the complete list in the background
          fetchFavorites(token);
          return true;
        }
      }
      print('Failed to add favorite. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;
    } catch (e) {
      print('Error adding to favorites: $e');
      return false;
    } finally {
      _productLoadingStates[productId] = false;
      notifyListeners();
    }
  }

  Future<bool> removeFromFavorites(String productId, String? token) async {
    if (token == null) return false;

    _productLoadingStates[productId] = true;
    notifyListeners();

    try {
      final response = await http.delete(
        Uri.parse('https://techwizard-7z3ua.ondigitalocean.app/api/wishlist/remove'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'product_id': productId,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == true) {
          // Remove from local list immediately
          _favorites.removeWhere((item) => item.productId == productId);
          notifyListeners();

          // Fetch the complete list in the background
          fetchFavorites(token);
          return true;
        }
      }
      print('Failed to remove favorite. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;
    } catch (e) {
      print('Error removing from favorites: $e');
      return false;
    } finally {
      _productLoadingStates[productId] = false;
      notifyListeners();
    }
  }

  // Clear favorites (useful for logout)
  void clearFavorites() {
    _favorites = [];
    _productLoadingStates.clear();
    _error = null;
    notifyListeners();
  }

  // Check if a product exists in favorites
  bool isFavorite(String productId) {
    return _favorites.any((item) => item.productId == productId);
  }
}