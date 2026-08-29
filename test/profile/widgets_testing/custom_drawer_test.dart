import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/profile/view/widgets/custom_user_drawer.dart';
void main() {
  group('CustomUserDrawer', () {
    test('creates drawer widget with correct token', () {
      const testToken = 'test_token_123';
      final drawer = CustomUserDrawer(token: testToken);
      expect(drawer.token, testToken);
      expect(drawer, isA<StatefulWidget>());
    });
    test('drawer stores and provides the correct token', () {
      const testToken = 'my_secret_token_xyz';
      final drawer = CustomUserDrawer(token: testToken);
      expect(drawer.token, testToken);
    });
    test('drawer renders with empty token', () {
      final drawer = CustomUserDrawer(token: '');
      expect(drawer.token, '');
    });
    test('drawer is a stateful widget', () {
      final drawer = CustomUserDrawer(token: 'token_test');
      expect(drawer, isA<StatefulWidget>());
      expect(drawer.token, 'token_test');
    });

    test('drawer widget has proper key support', () {
      final key = GlobalKey();
      final drawer = CustomUserDrawer(key: key, token: 'test');
      expect(drawer.key, key);
    });

    test('drawer token persists when widget is recreated', () {
      const token1 = 'token_one';
      const token2 = 'token_two';
      var drawer = CustomUserDrawer(token: token1);
      expect(drawer.token, token1);
      drawer = CustomUserDrawer(token: token2);
      expect(drawer.token, token2);
    });
    test('drawer handles long token strings', () {
      const longToken =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c';
      final drawer = CustomUserDrawer(token: longToken);
      expect(drawer.token, longToken);
      expect(drawer.token.length, greaterThan(50));
    });
    test('drawer handles special characters in token', () {
      const specialToken = 'token!@#\$%^&*()_+-={}[]|:;<>?,./';
      final drawer = CustomUserDrawer(token: specialToken);
      expect(drawer.token, specialToken);
    });
    test('multiple drawer instances maintain separate tokens', () {
      const token1 = 'drawer_token_1';
      const token2 = 'drawer_token_2';
      final drawer1 = CustomUserDrawer(token: token1);
      final drawer2 = CustomUserDrawer(token: token2);
      expect(drawer1.token, token1);
      expect(drawer2.token, token2);
      expect(drawer1.token, isNot(drawer2.token));
    });
    test('drawer equality based on token', () {
      const token = 'same_token';
      final drawer1 = CustomUserDrawer(token: token);
      final drawer2 = CustomUserDrawer(token: token);
      expect(drawer1.token, drawer2.token);
    });
  });
}