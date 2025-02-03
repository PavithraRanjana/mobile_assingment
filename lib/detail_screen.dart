// lib/screens/detail_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/cart_provider.dart';
import './cart_screen.dart';
import './sign_in_screen.dart';

class DetailScreen extends StatefulWidget {
  final String productSlug;

  const DetailScreen({
    Key? key,
    required this.productSlug,
  }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch product details
      Provider.of<ProductProvider>(context, listen: false)
          .fetchProductBySlug(widget.productSlug);

      // Fetch favorites if user is authenticated
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.isAuthenticated) {
        Provider.of<FavoritesProvider>(context, listen: false)
            .fetchFavorites(authProvider.token);
      }
    });
  }

  String _getDefaultPrice(List<dynamic> variants) {
    final defaultVariant = variants.firstWhere(
          (variant) => variant['is_default'] == true,
      orElse: () => variants.first,
    );
    return defaultVariant['price']['current'];
  }

  void _handleFavoritePress(BuildContext context, String productId, String productName,
      String productSlug, String productImage, String price) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);

    if (!authProvider.isAuthenticated) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sign In Required'),
          content: Text('Please sign in to add items to your favorites.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                );
              },
              child: Text('Sign In'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      bool success;
      if (favoritesProvider.isFavorite(productId)) {
        success = await favoritesProvider.removeFromFavorites(productId, authProvider.token);
      } else {
        success = await favoritesProvider.addToFavorites(productId, authProvider.token);
      }

      if (success) {
        await favoritesProvider.fetchFavorites(authProvider.token);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update favorites. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _handleAddToCart(BuildContext context, Map<String, dynamic> product) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (!authProvider.isAuthenticated) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sign In Required'),
          content: Text('Please sign in to add items to your cart.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                );
              },
              child: Text('Sign In'),
            ),
          ],
        ),
      );
      return;
    }

    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    try {
      // Get the product ID
      final String productId = product['id'];

      // Get the variant ID if available
      String? variantId;
      if (product['variants'] != null && product['variants'].isNotEmpty) {
        final defaultVariant = product['variants'].firstWhere(
              (variant) => variant['is_default'] == true,
          orElse: () => product['variants'][0],
        );
        variantId = defaultVariant['id'];
      }

      print('Adding to cart:');
      print('Product ID: $productId');
      print('Variant ID: $variantId');

      final success = await cartProvider.addToCart(
        productId,
        variantId,
        authProvider.token!,
      );

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product added to cart successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
            action: SnackBarAction(
              label: 'VIEW CART',
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(
                      onContinueShopping: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add product to cart. Please try again.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error adding to cart: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (provider.error != null) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text(provider.error!)),
          );
        }

        final product = provider.productDetails;
        if (product == null) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text('Product not found')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              product['name'],
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image with Favorite Icon
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: Image.network(
                        'https://techwizard-7z3ua.ondigitalocean.app${product['images']['primary']}',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.9),
                        child: Consumer2<AuthProvider, FavoritesProvider>(
                          builder: (context, auth, favorites, _) {
                            final productId = product['id'];
                            final isLoading = favorites.isProductLoading(productId);
                            final isFavorite = favorites.favorites.any((item) => item.productId == productId);

                            if (isLoading) {
                              return SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                                ),
                              );
                            }

                            return IconButton(
                              icon: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () => _handleFavoritePress(
                                context,
                                productId,
                                product['name'],
                                product['slug'],
                                product['images']['primary'],
                                _getDefaultPrice(product['variants']),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name
                      Text(
                        product['name'],
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),

                      // Price
                      Text(
                        '\$${_getDefaultPrice(product['variants'])}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 24),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Buy Now logic
                                _handleAddToCart(context, product);
                                // Navigate to cart
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CartScreen(
                                      onContinueShopping: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: Text('Buy Now'),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Consumer2<AuthProvider, CartProvider>(
                              builder: (context, auth, cart, _) => ElevatedButton(
                                onPressed: cart.isLoading
                                    ? null
                                    : () => _handleAddToCart(context, product),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.secondary,
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  disabledBackgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                                ),
                                child: cart.isLoading
                                    ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).colorScheme.onSecondary,
                                    ),
                                  ),
                                )
                                    : Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),

                      // Specifications
                      Text(
                        'Specifications',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      ...product['base_configuration'].entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '${entry.key}:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(entry.value.toString()),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      SizedBox(height: 24),

                      // Description
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        product['description'],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}