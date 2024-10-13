// import 'package:ecommerce_app1/providers/cart_items.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class CartItems extends ConsumerWidget {
//   const CartItems({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final cartProviders = ref.watch(cartProductsProviders);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cart'),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         itemCount: cartProviders.length,
//         padding: const EdgeInsets.all(16),
//         itemBuilder: (context, index) {
//           final product = cartProviders[index];
//           return Card(
//             elevation: 4,
//             margin: const EdgeInsets.only(bottom: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Product Image
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.network(
//                       product.images.isNotEmpty
//                           ? product.images[0]
//                           : 'https://placeholder.com/150',
//                       width: 100,
//                       height: 100,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return Container(
//                           width: 100,
//                           height: 100,
//                           color: Colors.grey[300],
//                           child: const Icon(Icons.image_not_supported,
//                               color: Colors.grey),
//                         );
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   // Product Details
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           product.title,
//                           style:
//                               Theme.of(context).textTheme.titleMedium!.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           '\$${product.price.toStringAsFixed(2)}',
//                           style: Theme.of(context)
//                               .textTheme
//                               .titleSmall!
//                               .copyWith(
//                                 color: Theme.of(context).colorScheme.primary,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             IconButton(
//                               icon: const Icon(Icons.remove_circle_outline),
//                               onPressed: () {
//                                 // Implement decrease quantity logic
//                               },
//                             ),
//                             Text(
//                               '1', // Replace with actual quantity
//                               style: Theme.of(context).textTheme.titleMedium,
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.add_circle_outline),
//                               onPressed: () {
//                                 // Implement increase quantity logic
//                               },
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Remove Button
//                   IconButton(
//                     icon: const Icon(Icons.delete_outline, color: Colors.red),
//                     onPressed: () {
//                       // Implement remove from cart logic
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//
import 'package:ecommerce_app1/providers/cart_items.dart';
import 'package:ecommerce_app1/providers/dark_light.dart';
import 'package:ecommerce_app1/providers/products_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItems extends ConsumerWidget {
  const CartItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProviders = ref.watch(cartNotifierProvider);
    final addTocartTotal = ref.watch(addCartItemsProvider);
    final filterdProduct = ref.watch(filteredProductsProvider);
    final isDarkMode = ref.watch(themeProvider);
    Widget contents = Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cartProviders.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final product = cartProviders[index];
              final newProduct = filterdProduct[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product.images.isNotEmpty
                              ? product.images[0]
                              : 'https://placeholder.com/150',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                              child: const Icon(Icons.image_not_supported,
                                  color: Colors.grey),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Product Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    ref
                                        .read(cartNotifierProvider.notifier)
                                        .removeCarts(product);
                                  },
                                ),
                                Text(
                                  '1', // Replace with actual quantity
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    ref
                                        .read(cartNotifierProvider.notifier)
                                        .addToCart(newProduct);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Remove Button
                      IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          color: isDarkMode.isDarkMode
                              ? Theme.of(context).colorScheme.tertiary
                              : Theme.of(context)
                                  .colorScheme
                                  .error
                                  .withOpacity(0.7),
                        ),
                        onPressed: () {
                          // Implement remove from cart logic
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        // Payment Method Button
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            //!
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: isDarkMode.isDarkMode
                ? const Color.fromARGB(255, 53, 135, 56)
                : const Color.fromARGB(255, 53, 135, 56),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      '\$ ${_calculateTotal(cartProviders).toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Implement navigation to payment method screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode.isDarkMode
                        ? Colors.white
                        : Colors.black87.withOpacity(0.8),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Proceed to Payment',
                    style: TextStyle(
                      color:
                          isDarkMode.isDarkMode ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
    if (cartProviders.isEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(
            'There is no cart, try to add cart...',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('\$${addTocartTotal.toStringAsFixed(1)}'),
        centerTitle: true,
      ),
      body: contents,
    );
  }

  double _calculateTotal(List<dynamic> cartItems) {
    return cartItems.fold(0, (total, item) => total + item.price);
  }
}
