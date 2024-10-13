import 'package:ecommerce_app1/models/products.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'cart_items.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
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

  void addToCart(Product product) {
    if (!state.contains(product)) {
      state = [...state, product];
    }
  }

  void removeCarts(Product product) {
    // Use where to remove the product
    state = state.where((item) => item != product).toList();
  }
}

@riverpod
int addCartItems(ref) {
  final cardProducts = ref.watch(cartNotifierProvider);
  double totalItems = 0;
  for (Product product in cardProducts) {
    totalItems += product.price;
  }

  return totalItems.toInt();
}
// final cartProductsProviders = NotifierProvider<CartNotifier, List<Product>>(() {
//   return CartNotifier();
// });
