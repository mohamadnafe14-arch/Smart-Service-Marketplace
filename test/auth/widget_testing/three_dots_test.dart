import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/dot.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/three_dots.dart';

void main() {
  Widget makeTestableWidget({required Animation<double> animation}) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: Scaffold(body: ThreeDots(animation: animation)),
        );
      },
    );
  }

  group('ThreeDots widget', () {
    testWidgets('renders exactly 3 Dot widgets', (WidgetTester tester) async {
      final controller = AnimationController(
        vsync: const TestVSync(),
        duration: const Duration(milliseconds: 900),
      );
      await tester.pumpWidget(makeTestableWidget(animation: controller));
      await tester.pumpAndSettle();
      expect(find.byType(Dot), findsNWidgets(3));
      controller.dispose();
    });
    testWidgets('no dots active when animation value is 0', (
      WidgetTester tester,
    ) async {
      final controller = AnimationController(
        vsync: const TestVSync(),
        duration: const Duration(milliseconds: 900),
        value: 0.0,
      );
      await tester.pumpWidget(makeTestableWidget(animation: controller));
      await tester.pumpAndSettle();
      final dots = tester.widgetList<Dot>(find.byType(Dot)).toList();
      expect(dots[0].isActive, isFalse);
      expect(dots[1].isActive, isFalse);
      expect(dots[2].isActive, isFalse);
      controller.dispose();
    });
    testWidgets('only first dot active when progress = 0.5 (segment=1.5)', (
      WidgetTester tester,
    ) async {
      final controller = AnimationController(
        vsync: const TestVSync(),
        duration: const Duration(milliseconds: 900),
        value: 0.5,
      );
      await tester.pumpWidget(makeTestableWidget(animation: controller));
      await tester.pumpAndSettle();
      final dots = tester.widgetList<Dot>(find.byType(Dot)).toList();
      expect(dots[0].isActive, isTrue);
      expect(dots[1].isActive, isTrue);
      expect(dots[2].isActive, isFalse);
      controller.dispose();
    });
    testWidgets('all dots active when animation value = 1', (
      WidgetTester tester,
    ) async {
      final controller = AnimationController(
        vsync: const TestVSync(),
        duration: const Duration(milliseconds: 900),
        value: 1.0, // segment = 3
      );
      await tester.pumpWidget(makeTestableWidget(animation: controller));
      await tester.pumpAndSettle();
      final dots = tester.widgetList<Dot>(find.byType(Dot)).toList();
      expect(dots[0].isActive, isTrue);
      expect(dots[1].isActive, isTrue);
      expect(dots[2].isActive, isTrue);
      controller.dispose();
    });
    testWidgets('rebuilds and updates active dots when animation changes', (
      WidgetTester tester,
    ) async {
      final controller = AnimationController(
        vsync: const TestVSync(),
        duration: const Duration(milliseconds: 900),
        value: 0.0,
      );
      await tester.pumpWidget(makeTestableWidget(animation: controller));
      await tester.pumpAndSettle();
      var dots = tester.widgetList<Dot>(find.byType(Dot)).toList();
      expect(dots[0].isActive, isFalse);
      controller.value = 1.0;
      await tester.pumpWidget(makeTestableWidget(animation: controller));
      await tester.pump();
      dots = tester.widgetList<Dot>(find.byType(Dot)).toList();
      expect(dots[0].isActive, isTrue);
      expect(dots[1].isActive, isTrue);
      expect(dots[2].isActive, isTrue);
      controller.dispose();
    });
  });
}
