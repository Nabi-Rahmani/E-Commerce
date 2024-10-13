// // ignore_for_file: collection_methods_unrelated_type, no_leading_underscores_for_local_identifiers, non_constant_identifier_names

// import 'package:ecommerce_app1/models/products.dart';
// import 'package:ecommerce_app1/presentation/widgets/discount_banner.dart';
// import 'package:ecommerce_app1/presentation/widgets/home_header.dart';
// import 'package:ecommerce_app1/providers/cart_items.dart';
// import 'package:ecommerce_app1/providers/favorite_items.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:ecommerce_app1/providers/dark_light.dart';
// import 'package:ecommerce_app1/providers/products_data.dart';

// class HomeScreen extends ConsumerStatefulWidget {
//   static const String id = 'home';
//   const HomeScreen({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
// }

// class _HomePageState extends ConsumerState<HomeScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//   late AnimationController _slideController;
//   late Animation<Offset> _slideAnimation;
//   @override
//   void initState() {
//     _animationController =
//         AnimationController(vsync: this, duration: const Duration(seconds: 1));
//     _animation = Tween<double>(begin: -1, end: -10).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeIn,
//     ));
//     super.initState();
//     _animationController
//       ..reset()
//       ..forward();

//     _slideController = AnimationController(
//       vsync: this,
//       duration: const Duration(
//         milliseconds: 600,
//       ),
//     );
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.9),
//       end: const Offset(0, 0),
//     ).animate(_slideController);
//     _slideController.forward();
//   }

//   @override
//   void dispose() {
//     _slideController.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _isthisDark = ref.watch(themeProvider);
//     final demoProducts = ref.watch(filteredProductsProvider);
//     final favoriteProductsF = ref.watch(favoriteItmesProvider);
//     final cartItemsProviders = ref.watch(cartNotifierProvider);

//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.secondary,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const HomeHeader(),
//             const DiscountBanner(),
//             PopupMenuButton<String>(
//               icon: const Icon(Icons.filter_list),
//               itemBuilder: (context) => [
//                 const PopupMenuItem(
//                   value: 'Low Price',
//                   child: Text('Low Price'),
//                 ),
//                 const PopupMenuItem(
//                   value: 'All Price',
//                   child: Text('nabi'),
//                 ),
//               ],
//             ),
//             const PopularProducts(),
//             Expanded(
//               child: AnimatedBuilder(
//                 animation: _slideController,
//                 builder: (BuildContext context, Widget? child) {
//                   return SlideTransition(
//                     position: _slideAnimation,
//                     child: GridView.builder(
//                       itemCount: demoProducts.length,
//                       padding: const EdgeInsets.all(10),
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 20,
//                         crossAxisSpacing: 20,
//                         childAspectRatio: 0.9,
//                       ),
//                       itemBuilder: (context, index) {
//                         final product = demoProducts[index];
//                         return Container(
//                           decoration: BoxDecoration(
//                             color: _isthisDark.isDarkMode
//                                 ? Theme.of(context).colorScheme.surface
//                                 : Theme.of(context).colorScheme.surface,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Image
//                               Expanded(
//                                 child: product.images.isNotEmpty
//                                     ? Container(
//                                         decoration: BoxDecoration(
//                                           color: _isthisDark.isDarkMode
//                                               ? Theme.of(context)
//                                                   .colorScheme
//                                                   .tertiary
//                                                   .withOpacity(0.1)
//                                               : Theme.of(context)
//                                                   .colorScheme
//                                                   .error
//                                                   .withOpacity(0.1),
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                         ),
//                                         child: Image.network(
//                                           product.images[0],
//                                           fit: BoxFit.fitHeight,
//                                           width: double.infinity,
//                                           errorBuilder:
//                                               (context, error, stackTrace) {
//                                             return const Center(
//                                                 child: Text(
//                                                     'Image not available'));
//                                           },
//                                         ),
//                                       )
//                                     : const Center(child: Text('No image')),
//                               ),
//                               // Title
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   product.title,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleMedium!
//                                       .copyWith(
//                                         color: _isthisDark.isDarkMode
//                                             ? Theme.of(context)
//                                                 .colorScheme
//                                                 .tertiary
//                                             : Theme.of(context)
//                                                 .colorScheme
//                                                 .tertiary,
//                                       ),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                               // Price
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: <Widget>[
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 8.0,
//                                       vertical: 8,
//                                     ),
//                                     child: Text(
//                                       '\$${product.price.toStringAsFixed(2)}',
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .titleSmall
//                                           ?.copyWith(
//                                             color: _isthisDark.isDarkMode
//                                                 ? Theme.of(context)
//                                                     .colorScheme
//                                                     .tertiary
//                                                 : Theme.of(context)
//                                                     .colorScheme
//                                                     .tertiary,
//                                           ),
//                                     ),
//                                   ),
//                                   if (favoriteProductsF
//                                       .contains(demoProducts[index]))
//                                     SizedBox(
//                                         width: 40,
//                                         height: 40,
//                                         child:
//                                             revmove_favorite(context, product)),
//                                   if (!favoriteProductsF
//                                       .contains(demoProducts[index]))
//                                     SizedBox(
//                                         width: 40,
//                                         height: 40,
//                                         child: add_favorite(product)),

// ignore_for_file: non_constant_identifier_names

//                                   ///Cart button
//                                   if (cartItemsProviders
//                                       .contains(demoProducts[index]))
//                                     TextButton(
//                                       onPressed: () {
//                                         ref
//                                             .read(cartNotifierProvider.notifier)
//                                             .removeCarts(product);
//                                         ScaffoldMessenger.of(context)
//                                             .clearSnackBars();
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(
//                                           SnackBar(
//                                             elevation: 5,
//                                             backgroundColor: Theme.of(context)
//                                                 .colorScheme
//                                                 .secondary,
//                                             content: Text(
//                                               'Removed from Cart',
//                                               style: TextStyle(
//                                                 color: Theme.of(context)
//                                                     .colorScheme
//                                                     .onSecondary,
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                       child: Text(
//                                         'Remove',
//                                         style: TextStyle(
//                                           color: _isthisDark.isDarkMode
//                                               ? Theme.of(context)
//                                                   .colorScheme
//                                                   .tertiary
//                                               : Theme.of(context)
//                                                   .colorScheme
//                                                   .error,
//                                         ),
//                                       ),
//                                     ),
//                                   if (!cartItemsProviders
//                                       .contains(demoProducts[index]))
//                                     TextButton(
//                                         onPressed: () {
//                                           ref
//                                               .read(
//                                                   cartNotifierProvider.notifier)
//                                               .addToCart(product);
//                                           ScaffoldMessenger.of(context)
//                                               .clearSnackBars();
//                                           ScaffoldMessenger.of(context)
//                                               .showSnackBar(
//                                             SnackBar(
//                                               elevation: 5,
//                                               backgroundColor: Theme.of(context)
//                                                   .colorScheme
//                                                   .secondary,
//                                               content: Text(
//                                                 'Added to Cart',
//                                                 style: TextStyle(
//                                                   color: Theme.of(context)
//                                                       .colorScheme
//                                                       .onSecondary,
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                         child: Text(
//                                           'Add',
//                                           style: TextStyle(
//                                             color: _isthisDark.isDarkMode
//                                                 ? Theme.of(context)
//                                                     .colorScheme
//                                                     .tertiary
//                                                 : Theme.of(context)
//                                                     .colorScheme
//                                                     .primary,
//                                           ),
//                                         ))
//                                 ],
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
import 'package:ecommerce_app1/models/products.dart';
import 'package:ecommerce_app1/presentation/Home/product_details_screen.dart';
import 'package:ecommerce_app1/presentation/widgets/discount_banner.dart';
import 'package:ecommerce_app1/presentation/widgets/home_header.dart';
import 'package:ecommerce_app1/providers/cart_items.dart';
import 'package:ecommerce_app1/providers/favorite_items.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_app1/providers/dark_light.dart';
import 'package:ecommerce_app1/providers/products_data.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String id = 'home';
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  // New state for tracking selected filter
  String _selectedFilter = 'All Price';

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(
          seconds: 2,
        ));
    _animation = Tween<double>(begin: -1, end: -10).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));
    super.initState();
    _animationController
      ..reset()
      ..forward();

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 600,
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.9),
      end: const Offset(0, 0),
    ).animate(_slideController);
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Product categorys) {
    final filteredProducts = demoProducts
        .where(
          (product) => product.id == categorys.id,
        )
        .toList();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProductDeatailScreen(
        title: categorys.title,
        procuts: filteredProducts,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    final demoProducts = _selectedFilter == 'Low Price'
        ? ref.watch(reduceDemoProductsProvidersProvider)
        : _selectedFilter == 'Low Rating'
            ? ref.watch(ratingProductProvidersProvider)
            : _selectedFilter == 'Top Rating'
                ? ref.watch(topRatingProvidersProvider)
                : _selectedFilter == 'Most Favorite'
                    ? ref.watch(mostFovoriteProviderProvider)
                    : _selectedFilter == 'Most Popular'
                        ? ref.watch(popularProductProviderProvider)
                        : ref.watch(filteredProductsProvider);
    final isthisDark = ref.watch(themeProvider);

    // Watch different providers based on the selected filter
    // final demoProducts = _selectedFilter == 'Low Price'
    //     ? ref.watch(reduceDemoProductsProvidersProvider)
    //     : ref.watch(filteredProductsProvider);

    final favoriteProductsF = ref.watch(favoriteItmesProvider);
    final cartItemsProviders = ref.watch(cartNotifierProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeader(),
            const DiscountBanner(),
            PopupMenuButton<String>(
              elevation: 30,
              color: isthisDark.isDarkMode
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.surface,
              icon: const Icon(Icons.filter_list),
              onSelected: (value) {
                setState(() {
                  _selectedFilter = value;
                });
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'Most Popular',
                  child: Text(
                    'Most Popular',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isthisDark.isDarkMode
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'Most Favorite',
                  child: Text(
                    'Most Favorite',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isthisDark.isDarkMode
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'Top Rating',
                  child: Text(
                    'Top Rating ⭐️⭐️⭐️⭐️',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isthisDark.isDarkMode
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'Low Rating',
                  child: Text(
                    'Low Rating ⭐️⭐️⭐️',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isthisDark.isDarkMode
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'Low Price',
                  child: Text(
                    'Low Price',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isthisDark.isDarkMode
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'All Price',
                  child: Text(
                    'All Price',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isthisDark.isDarkMode
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const PopularProducts(),
            Expanded(
              child: AnimatedBuilder(
                animation: _slideController,
                builder: (BuildContext context, Widget? child) {
                  return SlideTransition(
                    position: _slideAnimation,
                    child: GridView.builder(
                      itemCount: demoProducts.length,
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 3 / 5,
                      ),
                      itemBuilder: (context, index) {
                        final product = demoProducts[index];
                        return InkWell(
                          onTap: () {
                            _selectCategory(context, product);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isthisDark.isDarkMode
                                  ? Theme.of(context).colorScheme.surface
                                  : Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image
                                Expanded(
                                  child: product.images.isNotEmpty
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color: isthisDark.isDarkMode
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .tertiary
                                                    .withOpacity(0.1)
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .error
                                                    .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Image.network(
                                            product.images[0],
                                            fit: BoxFit.fitHeight,
                                            width: double.infinity,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Center(
                                                  child: Text(
                                                      'Image not available'));
                                            },
                                          ),
                                        )
                                      : const Center(child: Text('No image')),
                                ),

                                // Title
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    product.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: isthisDark.isDarkMode
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .tertiary
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .tertiary,
                                        ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // ratign
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${product.rating}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: isthisDark.isDarkMode
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .tertiary
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .tertiary,
                                            ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: Color(0xFFFFC107),
                                    ),
                                  ],
                                ),
                                // Price
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                        vertical: 8,
                                      ),
                                      child: Text(
                                        '\$${product.price.toStringAsFixed(2)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              color: isthisDark.isDarkMode
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .tertiary
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .tertiary,
                                            ),
                                      ),
                                    ),

                                    if (favoriteProductsF
                                        .contains(demoProducts[index]))
                                      SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: revmove_favorite(
                                              context, product)),
                                    if (!favoriteProductsF
                                        .contains(demoProducts[index]))
                                      SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: add_favorite(product)),

                                    ///Cart button
                                    if (cartItemsProviders
                                        .contains(demoProducts[index]))
                                      TextButton(
                                        onPressed: () {
                                          ref
                                              .read(
                                                  cartNotifierProvider.notifier)
                                              .removeCarts(product);
                                          ScaffoldMessenger.of(context)
                                              .clearSnackBars();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              elevation: 5,
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
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
                                          'Remove',
                                          style: TextStyle(
                                            color: isthisDark.isDarkMode
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .tertiary
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                          ),
                                        ),
                                      ),
                                    if (!cartItemsProviders
                                        .contains(demoProducts[index]))
                                      TextButton(
                                        onPressed: () {
                                          setState(() {});
                                          ref
                                              .read(
                                                  cartNotifierProvider.notifier)
                                              .addToCart(product);
                                          ScaffoldMessenger.of(context)
                                              .clearSnackBars();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              elevation: 5,
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              content: Text(
                                                'Added to Cart',
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
                                          'Add',
                                          style: TextStyle(
                                            color: isthisDark.isDarkMode
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .tertiary
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (product.isFavourite)
                                        const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                      if (product.isPopular)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Text(
                                            'Popular',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconButton revmove_favorite(BuildContext context, Product product) {
    final isDarkMode = ref.watch(themeProvider);
    return IconButton(
      icon: Icon(
        Icons.favorite,
        color: isDarkMode.isDarkMode
            ? Theme.of(context).colorScheme.tertiary
            : Theme.of(context).colorScheme.error.withOpacity(0.8),
      ),
      onPressed: () {
        ref.read(favoriteItmesProvider.notifier).removeFavorite(product);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            content: Text(
              'Removed from Favorite',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
        );
      },
    );
  }

  AnimatedBuilder add_favorite(Product products) {
    final isDarkMode = ref.watch(themeProvider);
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationZ(_animation.value * 60),
          // ..rotateZ(_animation.value),
          // ..rotateY(_animation.value),
          // ..rotateX(_animation.value),
          child: ScaleTransition(
            scale: _animationController,
            child: IconButton(
              icon: Icon(
                Icons.favorite_border,
                // products.isFavourite ? Icons.favorite : Icons.favorite_border,
                color: isDarkMode.isDarkMode
                    ? Theme.of(context).colorScheme.tertiary
                    : Theme.of(context).colorScheme.error.withOpacity(0.8),
              ),
              onPressed: () {
                ref.read(favoriteItmesProvider.notifier).addFavorite(products);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    elevation: 5,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    content: Text(
                      'Added to Favorite',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
      child: ScaleTransition(
        scale: _animation,
      ),
    );
  }
}
