// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class ProductModel {
  final String size;
  final String price;
  final Color color;
  final String description;

  ProductModel({
    required this.size,
    required this.price,
    required this.color,
    required this.description,
  });

  ProductModel copyWith({
    String? size,
    String? price,
    Color? color,
    String? description,
  }) {
    return ProductModel(
      size: size ?? this.size,
      price: price ?? this.price,
      color: color ?? this.color,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'size': size,
      'price': price,
      'color': color.value,
      'description': description,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      size: (map['size'] ?? '') as String,
      price: (map['price'] ?? 0.0) as String,
      color: Color((map['color']??0) as int),
      description: (map['description'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(size: $size, price: $price, color: $color, description: $description)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return
      other.size == size &&
      other.price == price &&
      other.color == color &&
      other.description == description;
  }

  @override
  int get hashCode {
    return size.hashCode ^
      price.hashCode ^
      color.hashCode ^
      description.hashCode;
  }
}
