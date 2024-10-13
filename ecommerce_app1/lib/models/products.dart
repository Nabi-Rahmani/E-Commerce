import 'dart:ui';

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });
  Product copyWith({bool? isFavourite}) {
    return Product(
      id: id,
      images: images,
      colors: colors,
      title: title,
      price: price,
      description: description,
      rating: rating,
      isFavourite: isFavourite ?? this.isFavourite,
      isPopular: isPopular,
    );
  }
}

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
