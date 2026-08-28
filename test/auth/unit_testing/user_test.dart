import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/auth/model/models/user_model.dart';

void main() {
  group('User Model', () {
    final sampleJson = {
      'email': 'test@example.com',
      'name': 'Ahmed Test',
      'token': 'abc123token',
      'id': 1,
      'role': 'admin',
    };

    test('All fields are correct', () {
      final user = UserModel(
        email: 'a@a.com',
        name: 'Ali',
        token: 'tok',
        id: 5,
        role: 'user',
      );

      expect(user.email, 'a@a.com');
      expect(user.name, 'Ali');
      expect(user.token, 'tok');
      expect(user.id, 5);
      expect(user.role, 'user');
    });

    group('fromJson', () {
      test('Json to User is correct', () {
        final user = UserModel.fromJson(sampleJson);

        expect(user.email, 'test@example.com');
        expect(user.name, 'Ahmed Test');
        expect(user.token, 'abc123token');
        expect(user.id, 1);
        expect(user.role, 'admin');
      });

      test('default values are correct', () {
        final user = UserModel.fromJson({});

        expect(user.email, '');
        expect(user.name, '');
        expect(user.token, '');
        expect(user.id, -1);
        expect(user.role, '');
      });

      test('Dealing with null values', () {
        final json = {
          'email': null,
          'name': null,
          'token': null,
          'id': null,
          'role': null,
        };

        final user = UserModel.fromJson(json);

        expect(user.email, '');
        expect(user.name, '');
        expect(user.token, '');
        expect(user.id, -1);
        expect(user.role, '');
      });

      test('Dealing with both null and non-null values', () {
        final json = {'email': 'partial@test.com', 'id': 10};

        final user = UserModel.fromJson(json);

        expect(user.email, 'partial@test.com');
        expect(user.name, '');
        expect(user.token, '');
        expect(user.id, 10);
        expect(user.role, '');
      });
    });

    group('toJson', () {
      test('To json is correct', () {
        final user = UserModel(
          email: 'test@example.com',
          name: 'Ahmed Test',
          token: 'abc123token',
          id: 1,
          role: 'admin',
        );

        final json = user.toJson();

        expect(json, {
          'email': 'test@example.com',
          'name': 'Ahmed Test',
          'token': 'abc123token',
          'id': 1,
          'role': 'admin',
        });
      });

      test('From Json and To Json are inverse', () {
        final user = UserModel.fromJson(sampleJson);
        final resultJson = user.toJson();

        expect(resultJson, sampleJson);
      });
    });

    group('copyWith', () {
      final original = UserModel(
        email: 'original@test.com',
        name: 'Original Name',
        token: 'original-token',
        id: 1,
        role: 'user',
      );

      test('Checking all fields after copying', () {
        final copy = original.copyWith();

        expect(copy.email, original.email);
        expect(copy.name, original.name);
        expect(copy.token, original.token);
        expect(copy.id, original.id);
        expect(copy.role, original.role);
      });

      test('Checking all fields after copying with one field', () {
        final copy = original.copyWith(name: 'New Name');

        expect(copy.name, 'New Name');
        expect(copy.email, original.email);
        expect(copy.token, original.token);
        expect(copy.id, original.id);
        expect(copy.role, original.role);
      });

      test('Checking all fields after copying with multiple fields', () {
        final copy = original.copyWith(
          email: 'new@test.com',
          name: 'New Name',
          token: 'new-token',
          id: 99,
          role: 'admin',
        );

        expect(copy.email, 'new@test.com');
        expect(copy.name, 'New Name');
        expect(copy.token, 'new-token');
        expect(copy.id, 99);
        expect(copy.role, 'admin');
      });

      test('Checking one field after copying', () {
        original.copyWith(name: 'Changed');

        expect(original.name, 'Original Name');
      });
    });
  });
}
