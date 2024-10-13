import 'package:ecommerce_app1/models/products.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'favorite_items.g.dart';

@riverpod
class FavoriteItmes extends _$FavoriteItmes {
  @override
  List<Product> build() {
    return [
      // Product(
      //   id: 1,
      //   images: [
      //     "https://apple-store.ifuture.co.in/wp-content/uploads/2024/09/Buy-iPhone-16.png"
      //   ],
      //   colors: [
      //     const Color(0xFFF6625E),
      //     const Color(0xFF836DB8),
      //     const Color(0xFFDECB9C),
      //     Colors.white,
      //   ],
      //   title: "Iphone 16 ™",
      //   price: 64.99,
      //   description: description,
      //   rating: 4.8,
      //   isFavourite: true,
      //   isPopular: true,
      // ),
    ];
  }

  void addFavorite(Product product) {
    if (!state.contains(product)) {
      state = [...state, product];
    }
  }

  void removeFavorite(Product product) {
    // Use where to remove the product
    state = state.where((item) => item != product).toList();
  }
}

// final favoriteProductProviders = NotifierProvider<FavoriteItmes, List<Product>>(
//   () {
//     return FavoriteItmes();
//   },
// );
