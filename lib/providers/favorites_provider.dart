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

  List<FavoriteItem> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String? get error => _error;

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
      _error = 'Network error occurred';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addToFavorites(String productId, String? token) async {
    if (token == null) return false;

    try {
      final response = await http.post(
        Uri.parse('https://techwizard-7z3ua.ondigitalocean.app/api/wishlist'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'product_id': productId,
        }),
      );

      if (response.statusCode == 200) {
        await fetchFavorites(token);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeFromFavorites(String productId, String? token) async {
    if (token == null) return false;

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
        await fetchFavorites(token);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}