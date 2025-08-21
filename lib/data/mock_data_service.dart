import 'dart:async';
import 'dart:math';

import 'package:capstone_proj/data/models/product.dart';

enum ProductCategory {
  all,
  riceMeals,
  noodles,
  dimsum,
  drinks,
  desserts,
}

class MockDataService {
  // Singleton pattern
  static final MockDataService _instance = MockDataService._internal();
  factory MockDataService() => _instance;
  MockDataService._internal() {
    // Initialize with sample data
    _initializeMockData();
  }

  // Simulate network delay
  final bool _simulateNetwork = true;
  final int _networkDelay = 1; // seconds
  
  // Mock products list
  final List<Product> _mockProducts = [];
  
  // Error simulation
  bool _shouldSimulateError = false;
  
  void _initializeMockData() {
    _mockProducts.addAll([
      Product(
        id: '1',
        name: 'Chao Fan Special',
        description: 'Premium fried rice with mixed seafood, chicken, and special sauce',
        price: 129.00,
        imageUrl: 'assets/chaopan/chaofan.jpg',
        category: ProductCategory.riceMeals,
        isPopular: true,
        rating: 4.8,
        reviewCount: 124,
      ),
      Product(
        id: '2',
        name: 'Pork Siomai (6pcs)',
        description: 'Steamed pork dumplings with garlic and special sauce',
        price: 89.00,
        imageUrl: 'assets/chaopan/siomai.jpg',
        category: ProductCategory.dimsum,
        isPopular: true,
        rating: 4.9,
        reviewCount: 256,
      ),
      Product(
        id: '3',
        name: 'Beef Chao Fan',
        description: 'Savory beef fried rice with vegetables and egg',
        price: 119.00,
        imageUrl: 'assets/chaopan/beef_chaofan.jpg',
        category: ProductCategory.riceMeals,
        isPopular: false,
        rating: 4.5,
        reviewCount: 87,
      ),
      Product(
        id: '4',
        name: 'Seafood Noodle Soup',
        description: 'Hot noodle soup with assorted seafood in rich broth',
        price: 149.00,
        imageUrl: 'assets/chaopan/seafood_noodle.jpg',
        category: ProductCategory.noodles,
        isPopular: true,
        rating: 4.7,
        reviewCount: 203,
      ),
      Product(
        id: '5',
        name: 'Iced Tea (Large)',
        description: 'Refreshing iced tea, perfect with any meal',
        price: 45.00,
        imageUrl: 'assets/chaopan/iced_tea.jpg',
        category: ProductCategory.drinks,
        isPopular: false,
        rating: 4.3,
        reviewCount: 56,
      ),
    ]);
  }

  // Simulate network delay
  Future<void> _simulateNetworkCall() async {
    if (_simulateNetwork) {
      await Future.delayed(Duration(seconds: _networkDelay));
    }
  }

  // Simulate random failures (10% chance)
  bool _shouldFail() {
    if (!_simulateNetwork) return false;
    return Random().nextDouble() < 0.1; // 10% chance of failure
  }

  // Get all products with optional filtering
  Future<List<Product>> getProducts({
    ProductCategory category = ProductCategory.all,
    String? searchQuery,
    bool onlyAvailable = true,
    bool onlyPopular = false,
    int limit = 20,
    int offset = 0,
  }) async {
    await _simulateNetworkCall();
    
    if (_shouldSimulateError) {
      throw Exception('Failed to fetch products. Please try again later.');
    }

    var products = _mockProducts.where((product) {
      // Filter by category
      if (category != ProductCategory.all && product.category != category) {
        return false;
      }
      
      // Filter by availability
      if (onlyAvailable && !product.isAvailable) {
        return false;
      }
      
      // Filter by popularity
      if (onlyPopular && !product.isPopular) {
        return false;
      }
      
      // Search by name or description
      if (searchQuery != null && searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        if (!product.name.toLowerCase().contains(query) &&
            !product.description.toLowerCase().contains(query)) {
          return false;
        }
      }
      
      return true;
    }).toList();

    // Apply pagination
    final start = offset;
    final end = start + limit;
    return products.sublist(
      start.clamp(0, products.length),
      end.clamp(0, products.length),
    );
  }

  // Get product by ID
  Future<Product?> getProductById(String id) async {
    await _simulateNetworkCall();
    
    if (_shouldSimulateError && _shouldFail()) {
      throw Exception('Failed to fetch product details. Please try again.');
    }
    
    try {
      return _mockProducts.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get featured products (popular and available)
  Future<List<Product>> getFeaturedProducts({int limit = 5}) async {
    await _simulateNetworkCall();
    return getProducts(
      onlyPopular: true,
      onlyAvailable: true,
      limit: limit,
    );
  }

  // Get products by category
  Future<List<Product>> getProductsByCategory(ProductCategory category, {int limit = 10}) async {
    await _simulateNetworkCall();
    return getProducts(
      category: category,
      onlyAvailable: true,
      limit: limit,
    );
  }

  // Search products
  Future<List<Product>> searchProducts(String query, {int limit = 10}) async {
    await _simulateNetworkCall();
    return getProducts(
      searchQuery: query,
      limit: limit,
    );
  }

  // Add new product
  Future<Product> addProduct(Product product) async {
    await _simulateNetworkCall();
    
    if (_shouldSimulateError && _shouldFail()) {
      throw Exception('Failed to add product. Please try again.');
    }
    
    final nextId = ((int.tryParse(_mockProducts.lastOrNull?.id ?? '0') ?? 0) + 1).toString();
    final newProduct = product.copyWith(
      id: nextId,
      createdAt: DateTime.now(),
    );
    
    _mockProducts.add(newProduct);
    return newProduct;
  }

  // Update existing product
  Future<Product> updateProduct(Product updatedProduct) async {
    await _simulateNetworkCall();
    
    if (_shouldSimulateError && _shouldFail()) {
      throw Exception('Failed to update product. Please try again.');
    }
    
    final index = _mockProducts.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      _mockProducts[index] = updatedProduct;
      return updatedProduct;
    }
    
    throw Exception('Product not found');
  }

  // Delete product
  Future<bool> deleteProduct(String id) async {
    await _simulateNetworkCall();
    
    if (_shouldSimulateError && _shouldFail()) {
      throw Exception('Failed to delete product. Please try again.');
    }
    
    final initialLength = _mockProducts.length;
    _mockProducts.removeWhere((product) => product.id == id);
    return _mockProducts.length < initialLength;
  }
  
  // Toggle error simulation
  void toggleErrorSimulation(bool shouldSimulate) {
    _shouldSimulateError = shouldSimulate;
  }
  
  // Clear all mock data (for testing)
  void clearMockData() {
    _mockProducts.clear();
  }
  
  // Reload mock data (for testing)
  void reloadMockData() {
    _mockProducts.clear();
    _initializeMockData();
  }
}
