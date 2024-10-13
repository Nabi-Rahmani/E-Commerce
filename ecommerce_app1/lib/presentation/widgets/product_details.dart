import 'package:ecommerce_app1/models/products.dart';
import 'package:ecommerce_app1/providers/dark_light.dart';
import 'package:ecommerce_app1/utils/appsize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetails extends ConsumerWidget {
  const ProductDetails({super.key, required this.productitems});
  final Product productitems;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.width * 0.6,
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: isDarkMode.isDarkMode
                  ? Colors.green
                  : const Color(0xFFFFC107),
              elevation: 5,
              child: Stack(
                children: [
                  Image.network(
                    productitems.images.isNotEmpty
                        ? productitems.images[0]
                        : 'https://placeholder.com/150',
                    width: 200,
                    height: 200,
                    fit: BoxFit.fitHeight,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 200,
                        height: 200,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                        ),
                        color: Colors.black38,
                      ),
                      child: Column(
                        children: [
                          Text(
                            productitems.title,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isDarkMode.isDarkMode
                  ? Colors.green
                  : const Color(0xFFFFC107),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${productitems.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color.fromARGB(
                          255, 255, 255, 255), // Use the correct hex format
                      size: 16,
                    ),
                    AppSizing.k20(context),
                    Text(
                      productitems.rating.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Descriptions',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),

        const SizedBox(height: 5),

        // Description (if needed)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            productitems.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Favourite and Popular badges
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (productitems.isFavourite)
                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              if (productitems.isPopular)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
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
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          child: CustomPaint(
            painter: SignalWavePainter(
              color: isDarkMode.isDarkMode
                  ? Colors.green
                  : const Color(0xFFFFC107),
            ),
            // Add a background color here
            // Or any desired color
          ),
        )
      ],
    );
  }
}

class SignalWavePainter extends CustomPainter {
  SignalWavePainter({required this.color});
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    // Move to the top left corner of the screen
    path.moveTo(0, 0);

    // First wave
    path.quadraticBezierTo(
      size.width * 0.0,
      size.height * 0.5, // Adjust Y-position for top wave
      size.width * 0.5,
      0, // Top of the screen
    );

    // Second wave
    path.quadraticBezierTo(
      size.width * 0.90,
      size.height * 0.100, // Adjust Y-position for bottom wave
      size.width,
      0, // Top of the screen
    );

    // Completing the bottom shape
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // ... rest of the code for lighter blue overlay (optional)
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


// class SignalWavePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.blue[900]!
//       ..style = PaintingStyle.fill;

//     final path = Path();

//     path.moveTo(0, size.height * 0.7);

//     // First wave
//     path.quadraticBezierTo(
//       size.width * 0.25,
//       size.height * 0.55,
//       size.width * 0.5,
//       size.height * 0.7,
//     );

//     // Second wave
//     path.quadraticBezierTo(
//       size.width * 0.75,
//       size.height * 0.85,
//       size.width,
//       size.height * 0.7,
//     );

//     // Completing the shape
//     path.lineTo(size.width, size.height);
//     path.lineTo(2, size.height);
//     path.close();

//     canvas.drawPath(path, paint);

//     // Adding a lighter blue overlay for depth
//     final lightPaint = Paint()
//       ..color = Colors.blue[700]!.withOpacity(0.5)
//       ..style = PaintingStyle.fill;

//     final lightPath = Path();
//     lightPath.moveTo(0, size.height * 0.75);

//     // Light overlay wave
//     lightPath.quadraticBezierTo(
//       size.width * 0.35,
//       size.height * 0.65,
//       size.width * 0.7,
//       size.height * 0.75,
//     );
//     lightPath.quadraticBezierTo(
//       size.width * 0.85,
//       size.height * 0.8,
//       size.width,
//       size.height * 0.75,
//     );

//     lightPath.lineTo(size.width, size.height);
//     lightPath.lineTo(0, size.height);
//     lightPath.close();

//     canvas.drawPath(lightPath, lightPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }