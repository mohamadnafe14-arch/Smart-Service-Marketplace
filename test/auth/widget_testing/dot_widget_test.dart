import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/dot.dart';
void main() {
  Widget makeTestableWidget({required bool isActive}) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), 
      builder: (context, child) {
        return MaterialApp(
          home: Scaffold(
            body: Dot(isActive: isActive),
          ),
        );
      },
    );
  }
  group('Dot widget', () {
    testWidgets('renders correctly when active', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(isActive: true));
      await tester.pumpAndSettle();
      final finder = find.byType(AnimatedContainer);
      expect(finder, findsOneWidget);
      final animatedContainer = tester.widget<AnimatedContainer>(finder);
      final decoration = animatedContainer.decoration as BoxDecoration;
      expect(decoration.color, Colors.lightBlueAccent);
      expect(decoration.shape, BoxShape.circle);
    });
    testWidgets('renders correctly when inactive', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(isActive: false));
      await tester.pumpAndSettle();
      final finder = find.byType(AnimatedContainer);
      expect(finder, findsOneWidget);
      final animatedContainer = tester.widget<AnimatedContainer>(finder);
      final decoration = animatedContainer.decoration as BoxDecoration;
      expect(decoration.color, Colors.white24);
      expect(decoration.shape, BoxShape.circle);
    });
    testWidgets('size changes when isActive toggles', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(isActive: false));
      await tester.pumpAndSettle();
      final inactiveSize = tester.getSize(find.byType(AnimatedContainer));
      await tester.pumpWidget(makeTestableWidget(isActive: true));
      await tester.pump(); // start animation
      await tester.pump(const Duration(milliseconds: 300)); // خلص الـ animation
      await tester.pumpAndSettle();
      final activeSize = tester.getSize(find.byType(AnimatedContainer));
      expect(activeSize.width, greaterThan(inactiveSize.width));
      expect(activeSize.height, greaterThan(inactiveSize.height));
    });
  });
}