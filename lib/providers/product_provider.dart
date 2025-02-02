// lib/providers/product_provider.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ProductProvider with ChangeNotifier {
  Map<String, dynamic>? _productDetails;
  bool _isLoading = false;
  String? _error;

  Map<String, dynamic>? get productDetails => _productDetails;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProductBySlug(String slug) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://techwizard-7z3ua.ondigitalocean.app/api/products/$slug'),
      );

      if (response.statusCode == 200) {
        _productDetails = json.decode(response.body);
        _error = null;
      } else {
        _error = 'Failed to load product details';
      }
    } catch (e) {
      _error = 'Network error occurred';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}