// lib/models/product.dart

class Product {
  final String id;
  final String name;
  final String slug;
  final String description;
  final Map<String, dynamic> images;
  final String brandId;  // Changed to store brandId
  final Map<String, dynamic> baseConfiguration;
  final List<Map<String, dynamic>> variants;

  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.images,
    required this.brandId,
    required this.baseConfiguration,
    required this.variants,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      images: json['images'],
      brandId: json['brand']['\$id'], // Extract brandId from reference
      baseConfiguration: json['base_configuration'],
      variants: List<Map<String, dynamic>>.from(json['variants']),
    );
  }

  String get defaultPrice {
    final defaultVariant = variants.firstWhere(
          (variant) => variant['is_default'] == true,
      orElse: () => variants.first,
    );
    return defaultVariant['price']['current'];
  }
}