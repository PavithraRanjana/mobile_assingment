// lib/providers/brand_provider.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Brand {
  final String id;
  final String name;
  final String logo;
  final bool isActive;
  final String slug;
  final String description;

  Brand({
    required this.id,
    required this.name,
    required this.logo,
    required this.isActive,
    required this.slug,
    required this.description,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      logo: json['logo']['primary'], // Access primary logo from nested object
      isActive: json['metadata']['is_active'], // Access is_active from metadata
    );
  }
}

class BrandProvider with ChangeNotifier {
  List<Brand> _brands = [];
  bool _isLoading = false;
  String? _error;

  List<Brand> get brands => _brands;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchBrands() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://techwizard-7z3ua.ondigitalocean.app/api/brands'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> brandsJson = responseData['data']; // Access the data array
        _brands = brandsJson.map((brand) => Brand.fromJson(brand)).toList();
        _error = null;
      } else {
        _error = 'Failed to load brands';
      }
    } catch (e) {
      _error = 'Network error occurred: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}