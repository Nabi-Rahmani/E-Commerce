import 'package:ecommerce_app1/models/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'products_data.g.dart';

List<Product> demoProducts = [
  Product(
    id: 1,
    images: [
      "https://apple-store.ifuture.co.in/wp-content/uploads/2024/09/Buy-iPhone-16.png"
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Iphone 16 -Pink ™",
    price: 64.99,
    description: 'Latest iPhone with advanced camera, long battery, and 5G.',
    rating: 4.8,
    isFavourite: false,
    isPopular: false,
  ),
  Product(
    id: 2,
    images: [
      "https://r2.erweima.ai/imgcompressed/compressed_4024854202d2671f207e86057d4c16f6.webp",
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Nike Sport Grey - Man Shoes ™",
    price: 12.5,
    description:
        'Comfortable and stylish Nike shoes for daily wear and sports.',
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 3,
    images: [
      "https://r2.erweima.ai/imgcompressed/compressed_16d109e9d7c0275d27bd2ff5ba8bc8b6.webp",
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Sport Bycicle - Blue ™",
    price: 38.55,
    description:
        'Durable blue sport bike, perfect for casual rides and workouts.',
    rating: 3.1,
    isFavourite: false,
    isPopular: true,
  ),
  Product(
    id: 4,
    images: [
      "https://r2.erweima.ai/imgcompressed/compressed_e519a367cab9726bda8a9d55615fcc41.webp",
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "VR -Natural - View ™",
    price: 200.55,
    description:
        'High-end VR headset with immersive visuals and wide field of view.',
    rating: 4.7,
    isFavourite: false,
    isPopular: true,
  ),
  Product(
    id: 5,
    images: [
      "https://r2.erweima.ai/imgcompressed/compressed_6b1f4e0206e3d15a9593de8db4614296.webp",
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Sport Bycicle -Child ™",
    price: 36.55,
    description:
        'Safe, child-friendly bike with training wheels and adjustable settings.',
    rating: 2.1,
    isFavourite: false,
    isPopular: false,
  ),
  Product(
    id: 6,
    images: [
      "https://r2.erweima.ai/imgcompressed/compressed_d3c3e8e53ba66ff88fc080e8cc6ee72e.webp",
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Crafting-a-Golden-Chainsaw ™",
    price: 100.55,
    description:
        'Precision-crafted golden chainsaw for professionals or collectors.',
    rating: 3.9,
    isFavourite: true,
    isPopular: false,
  ),
  Product(
    id: 7,
    images: [
      "https://www.pngarts.com/files/8/Apple-Watch-Download-Transparent-PNG-Image.png",
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Apple Watch -New Brand ™",
    price: 200.55,
    description:
        'New Apple Watch with health tracking and seamless device integration.',
    rating: 4.4,
    isFavourite: false,
    isPopular: true,
  ),
  Product(
    id: 8,
    images: [
      "https://api.mobilaty.com/storage/uploads/1-2-1724081608.png",
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Iphone 15 Pro Max - Dark Blue ™",
    price: 200.55,
    description:
        'Powerful iPhone with a pro camera and sleek dark blue finish.',
    rating: 5.0,
    isFavourite: true,
    isPopular: true,
  ),
];
// final demoProductsProviders = Provider((ref) {
//   return demoProducts;
// });

// final reduceafghanFoodProductProvider = Provider((ref) {
//   return allprudcts.where((prices) => prices.price < 40);
// });
/// for suggest top price for user
@riverpod
List<Product> demoProductsProviders(ref) {
  return demoProducts;
}

// for suggest low price to user
@riverpod
List<Product> reduceDemoProductsProviders(ref) {
  return demoProducts.where((prices) => prices.price < 40).toList();
}

// filter base on low rating products
@riverpod
List<Product> ratingProductProviders(ref) {
  return demoProducts.where((prices) => prices.rating < 4).toList();
}

// filter base on top rating products
@riverpod
List<Product> topRatingProviders(ref) {
  return demoProducts.where((prices) => prices.rating > 4).toList();
}

// filter base on most favorite products
@riverpod
List<Product> mostFovoriteProvider(ref) {
  return demoProducts.where((prices) => prices.isFavourite == true).toList();
}

// filter base on most popular products
@riverpod
List<Product> popularProductProvider(ref) {
  return demoProducts.where((prices) => prices.isPopular == true).toList();
}

// for searching products
final searchQueryProvider = StateProvider<String>((ref) => '');
// filterd products for user base on user behaviour
@riverpod
List<Product> filteredProducts(ref) {
  final allProducts = ref.watch(demoProductsProvidersProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();

  // Filter products based on search query
  List<Product> filteredProducts = allProducts.where((product) {
    return product.title.toLowerCase().contains(searchQuery) ||
        product.description.toLowerCase().contains(searchQuery);
  }).toList();

  // Sort the filtered products by price (low to high)
  filteredProducts.sort((a, b) => a.price.compareTo(b.price));

  return filteredProducts;
}
