import 'dart:convert';
import 'package:smart_service_market_place/features/auth/model/models/google_credintials_model.dart';
import 'package:test/test.dart';
void main() {
  group('GoogleCredintialsModel', () {
    const token = 'sample_token_123';
    const email = 'user@example.com';
    test('constructor assigns fields correctly', () {
      final model = GoogleCredintialsModel(token: token, email: email);
      expect(model.token, token);
      expect(model.email, email);
    });
    group('copyWith', () {
      test('returns same values when no arguments passed', () {
        final model = GoogleCredintialsModel(token: token, email: email);
        final copy = model.copyWith();
        expect(copy.token, token);
        expect(copy.email, email);
        expect(copy, equals(model));
      });
      test('overrides token only', () {
        final model = GoogleCredintialsModel(token: token, email: email);
        final copy = model.copyWith(token: 'new_token');
        expect(copy.token, 'new_token');
        expect(copy.email, email);
      });
      test('overrides email only', () {
        final model = GoogleCredintialsModel(token: token, email: email);
        final copy = model.copyWith(email: 'new@example.com');
        expect(copy.token, token);
        expect(copy.email, 'new@example.com');
      });
      test('overrides both fields', () {
        final model = GoogleCredintialsModel(token: token, email: email);
        final copy = model.copyWith(token: 'new_token', email: 'new@example.com');
        expect(copy.token, 'new_token');
        expect(copy.email, 'new@example.com');
      });
    });
    group('toMap / fromMap', () {
      test('toMap returns correct map', () {
        final model = GoogleCredintialsModel(token: token, email: email);
        final map = model.toMap();
        expect(map, {
          'token': token,
          'email': email,
        });
      });
      test('fromMap returns correct model', () {
        final map = {'token': token, 'email': email};
        final model = GoogleCredintialsModel.fromMap(map);
        expect(model.token, token);
        expect(model.email, email);
      });
      test('fromMap throws when token is missing/wrong type', () {
        final map = {'token': null, 'email': email};
        expect(() => GoogleCredintialsModel.fromMap(map), throwsA(isA<TypeError>()));
      });
      test('toMap -> fromMap round trip preserves data', () {
        final model = GoogleCredintialsModel(token: token, email: email);
        final result = GoogleCredintialsModel.fromMap(model.toMap());
        expect(result, model);
      });
    });
    group('toJson / fromJson', () {
      test('toJson returns valid JSON string', () {
        final model = GoogleCredintialsModel(token: token, email: email);
        final jsonStr = model.toJson();
        final decoded = json.decode(jsonStr);
        expect(decoded['token'], token);
        expect(decoded['email'], email);
      });
      test('fromJson returns correct model', () {
        final jsonStr = json.encode({'token': token, 'email': email});
        final model = GoogleCredintialsModel.fromJson(jsonStr);
        expect(model.token, token);
        expect(model.email, email);
      });
      test('toJson -> fromJson round trip preserves data', () {
        final model = GoogleCredintialsModel(token: token, email: email);
        final result = GoogleCredintialsModel.fromJson(model.toJson());
        expect(result, model);
      });
    });
    group('toString', () {
      test('returns expected string representation', () {
        final model = GoogleCredintialsModel(token: token, email: email);
        expect(model.toString(), 'GoogleCredintialsModel(token: $token, email: $email)');
      });
    });
    group('equality & hashCode', () {
      test('two instances with same values are equal', () {
        final a = GoogleCredintialsModel(token: token, email: email);
        final b = GoogleCredintialsModel(token: token, email: email);
        expect(a, equals(b));
        expect(a.hashCode, equals(b.hashCode));
      });
      test('identical instance is equal to itself', () {
        final a = GoogleCredintialsModel(token: token, email: email);
        expect(a == a, isTrue);
      });
      test('instances with different token are not equal', () {
        final a = GoogleCredintialsModel(token: token, email: email);
        final b = GoogleCredintialsModel(token: 'different', email: email);
        expect(a == b, isFalse);
      });
      test('instances with different email are not equal', () {
        final a = GoogleCredintialsModel(token: token, email: email);
        final b = GoogleCredintialsModel(token: token, email: 'different@example.com');
        expect(a == b, isFalse);
      });
      test('instances with all different fields are not equal', () {
        final a = GoogleCredintialsModel(token: token, email: email);
        final b = GoogleCredintialsModel(token: 'x', email: 'y@example.com');
        expect(a == b, isFalse);
      });
    });
  });
}