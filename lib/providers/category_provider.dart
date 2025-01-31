// lib/providers/category_provider.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/category.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];
  List<dynamic>? _categoryProducts;
  bool _isLoading = false;
  String? _error;

  // Getters
  List<Category> get categories => _categories;
  List<dynamic>? get categoryProducts => _categoryProducts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch all categories
  Future<void> fetchCategories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://techwizard-7z3ua.ondigitalocean.app/api/categories'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> categoriesJson = json.decode(response.body);
        _categories = categoriesJson
            .map((category) => Category.fromJson(category))
            .toList();
        _error = null;
      } else {
        _error = 'Failed to load categories';
      }
    } catch (e) {
      _error = 'Network error occurred';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch category by slug
  Future<Category?> fetchCategoryBySlug(String slug) async {
    try {
      _isLoading = true;
      _categoryProducts = null;
      notifyListeners();

      final response = await http.get(
        Uri.parse('https://techwizard-7z3ua.ondigitalocean.app/api/categories/$slug'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _categoryProducts = data['products']['data'];
        return Category.fromJson(data['category']);
      }
      return null;
    } catch (e) {
      _error = 'Network error occurred';
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}