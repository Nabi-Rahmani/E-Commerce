import 'package:ecommerce_app1/providers/cart_items.dart';
import 'package:ecommerce_app1/providers/dark_light.dart';
import 'package:ecommerce_app1/providers/favorite_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePage extends ConsumerWidget {
  static const String id = 'favorit';
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteProduct = ref.watch(favoriteItmesProvider);
    final addToCartProvider = ref.watch(cartNotifierProvider);
    final isthisDark = ref.watch(themeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite"),
      ),
      body: GridView.builder(
        itemCount: favoriteProduct.length,
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.9,
        ),
        itemBuilder: (context, index) {
          final product = favoriteProduct[index];
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    child: product.images.isNotEmpty
                        ? Image.network(
                            product.images[0],
                            fit: BoxFit.fitHeight,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                  child: Text('Image not available'));
                            },
                          )
                        : const Center(child: Text('No image')),
                  ),
                ),
                // Title
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 8,
                      ),
                      child: Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                      ),
                    ),
                    //ad cart
                    if (addToCartProvider.contains(favoriteProduct[index]))
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            ref
                                .read(cartNotifierProvider.notifier)
                                .removeCarts(product);
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                elevation: 5,
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                content: Text(
                                  'Removed from Cart',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Remove 🗑️',
                            style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: isthisDark.isDarkMode
                                  ? Theme.of(context).colorScheme.tertiary
                                  : Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ),
                      ),
                    if (!addToCartProvider.contains(favoriteProduct[index]))
                      TextButton(
                        onPressed: () {
                          ref
                              .read(cartNotifierProvider.notifier)
                              .addToCart(product);
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              elevation: 5,
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              content: Text(
                                'Added to Cart',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(
                            color: isthisDark.isDarkMode
                                ? Theme.of(context).colorScheme.tertiary
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
