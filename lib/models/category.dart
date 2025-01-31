// lib/models/category.dart

class Category {
  final String id;
  final String name;
  final String description;
  final String? parentCategory;
  final String image;
  final bool isActive;
  final String slug;
  final List<Category> children;

  Category({
    required this.id,
    required this.name,
    required this.description,
    this.parentCategory,
    required this.image,
    required this.isActive,
    required this.slug,
    required this.children,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      parentCategory: json['parent_category'],
      image: json['image'],
      isActive: json['is_active'],
      slug: json['slug'],
      children: (json['children'] as List<dynamic>?)
          ?.map((child) => Category.fromJson(child))
          .toList() ?? [],
    );
  }
}