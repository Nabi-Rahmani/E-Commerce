import 'package:ecommerce_app1/models/products.dart';
import 'package:ecommerce_app1/presentation/widgets/product_details.dart';
import 'package:flutter/material.dart';

class ProductDeatailScreen extends StatelessWidget {
  const ProductDeatailScreen(
      {super.key, required this.title, required this.procuts});
  final String title;
  final List<Product> procuts;
  @override
  Widget build(BuildContext context) {
    Widget contensts = ListView.builder(
        itemCount: procuts.length,
        itemBuilder: (context, index) {
          return ProductDetails(
            productitems: procuts[index],
          );
        });
    if (procuts.isEmpty) {
      return Scaffold(
        // appBar: AppBar(),
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              'ohh nothing found',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Try selecting a different category',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ]),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
      body: contensts,
    );
  }
}
