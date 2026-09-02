import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/services/model/models/category_model.dart';

void main() {
  group('CategoryModel', () {
    test('should create an instance with given title and icon', () {
      const model = CategoryModel(title: 'Food', icon: Icons.fastfood);

      expect(model.title, 'Food');
      expect(model.icon, Icons.fastfood);
    });

    test('should store different titles correctly', () {
      const model1 = CategoryModel(title: 'Transport', icon: Icons.directions_car);
      const model2 = CategoryModel(title: 'Shopping', icon: Icons.shopping_cart);

      expect(model1.title, isNot(equals(model2.title)));
    });

    test('title should be of type String', () {
      const model = CategoryModel(title: 'Health', icon: Icons.local_hospital);
      expect(model.title, isA<String>());
    });

    test('icon should be of type IconData', () {
      const model = CategoryModel(title: 'Health', icon: Icons.local_hospital);
      expect(model.icon, isA<IconData>());
    });

    test('two instances with same values should have equal fields', () {
      const model1 = CategoryModel(title: 'Bills', icon: Icons.receipt);
      const model2 = CategoryModel(title: 'Bills', icon: Icons.receipt);

      expect(model1.title, equals(model2.title));
      expect(model1.icon, equals(model2.icon));
    });

    test('fields are required and cannot be null', () {
      // This is compile-time enforced via `required`, but we confirm
      // the object is non-null once constructed.
      const model = CategoryModel(title: 'Entertainment', icon: Icons.movie);
      expect(model, isNotNull);
      expect(model.title, isNotNull);
      expect(model.icon, isNotNull);
    });
  });
}