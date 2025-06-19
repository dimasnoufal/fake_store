import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  bool isFavourite, isPopular;

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
}

Product sampleProduct = Product(
  id: 1,
  title: 'Sample Product',
  description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce vitae leo eu sapien ultrices pellentesque ut ut orci. Curabitur posuere, diam eu dapibus pharetra, eros diam iaculis mauris, at ultrices augue sapien quis massa. Ut tortor massa, tincidunt consequat vulputate eu, molestie sed magna. Ut urna augue, viverra ac sagittis at, vehicula sagittis elit. Sed gravida urna vitae diam rutrum, in vehicula quam sodales. Proin blandit dolor et lacus vestibulum, a dignissim turpis accumsan. Nulla non turpis semper, accumsan turpis ut, sodales libero. Cras ut odio posuere, cursus risus vel, laoreet tortor. Ut rhoncus lectus ipsum, sit amet dignissim justo tincidunt id. Praesent laoreet odio vel diam efficitur tempor. Proin sagittis commodo dapibus. Phasellus tincidunt massa orci, non convallis turpis efficitur a. Proin consectetur pretium urna, sed varius dui tempus sit amet. Nam consectetur gravida mi, at iaculis diam posuere ut. Ut eleifend ligula ut justo eleifend, eu malesuada nunc consequat. Suspendisse eget maximus mauris, nec mollis ipsum.',
  images: [
    "assets/images/ilustration_1.png",
    "assets/images/ilustration_2.png",
    "assets/images/ilustration_3.png",
  ],
  colors: [
    const Color(0xFFF6625E),
    const Color(0xFF836DB8),
    const Color(0xFFDECB9C),
    Colors.white,
  ],
  rating: 4.5,
  price: 29.99,
  isFavourite: true,
  isPopular: true,
);

class ProductItem {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  ProductItem({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      rating: Rating.fromJson(json['rating'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
        'rating': rating.toJson(),
      };

  ProductItem copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    Rating? rating,
  }) {
    return ProductItem(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      rating: rating ?? this.rating,
    );
  }
}

class Rating {
  final double rate;
  final int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num).toDouble(),
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'rate': rate,
        'count': count,
      };
}
