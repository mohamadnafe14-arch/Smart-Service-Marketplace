import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/custom_progress_bar.dart'; 
void main() {
  Widget makeTestableWidget({required Animation<double> animation}) {
    return MaterialApp(
      home: Scaffold(body: CustomProgressBar(animation: animation)),
    );
  }
  group('CustomProgressBar widget', () {
    testWidgets('renders a LinearProgressIndicator wrapped in ClipRRect', (
      WidgetTester tester,
    ) async {
      final controller = AnimationController(
        vsync: const TestVSync(),
        duration: const Duration(milliseconds: 900),
      );
      await tester.pumpWidget(makeTestableWidget(animation: controller));
      await tester.pumpAndSettle();
      expect(find.byType(ClipRRect), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
      controller.dispose();
    });
    testWidgets('has correct border radius', (WidgetTester tester) async {
      final controller = AnimationController(
        vsync: const TestVSync(),
        duration: const Duration(milliseconds: 900),
      );
      await tester.pumpWidget(makeTestableWidget(animation: controller));
      await tester.pumpAndSettle();
      final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect));
      expect(clipRRect.borderRadius, BorderRadius.circular(10));
      controller.dispose();
    });
    testWidgets('reflects initial animation value = 0', (
      WidgetTester tester,
    ) async {
      final controller = AnimationController(
        vsync: const TestVSync(),
        duration: const Duration(milliseconds: 900),
        value: 0.0,
      );
      await tester.pumpWidget(makeTestableWidget(animation: controller));
      await tester.pumpAndSettle();
      final progressIndicator = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(progressIndicator.value, 0.0);
      controller.dispose();
    });

    testWidgets('reflects initial animation value = 0.5', (
      WidgetTester tester,
    ) async {
      final controller = AnimationController(
        vsync: const TestVSync(),
        duration: const Duration(milliseconds: 900),
        value: 0.5,
      );
      await tester.pumpWidget(makeTestableWidget(animation: controller));
      await tester.pumpAndSettle();
      final progressIndicator = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(progressIndicator.value, 0.5);
      controller.dispose();
    });
    testWidgets('reflects initial animation value = 1.0', (
      WidgetTester tester,
    ) async {
      final controller = AnimationController(
        vsync: const TestVSync(),
        duration: const Duration(milliseconds: 900),
        value: 1.0,
      );
      await tester.pumpWidget(makeTestableWidget(animation: controller));
      await tester.pumpAndSettle();
      final progressIndicator = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(progressIndicator.value, 1.0);
      controller.dispose();
    });
    testWidgets('has correct minHeight, backgroundColor and valueColor', (
      WidgetTester tester,
    ) async {
      final controller = AnimationController(
        vsync: const TestVSync(),
        duration: const Duration(milliseconds: 900),
      );
      await tester.pumpWidget(makeTestableWidget(animation: controller));
      await tester.pumpAndSettle();
      final progressIndicator = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );

      expect(progressIndicator.minHeight, 8);
      expect(progressIndicator.backgroundColor, Colors.white24);
      expect(
        (progressIndicator.valueColor as AlwaysStoppedAnimation<Color?>).value,
        Colors.lightBlueAccent,
      );
      controller.dispose();
    });
    testWidgets(
      'does update LinearProgressIndicator value when animation value changes',
      (WidgetTester tester) async {
        final controller = AnimationController(
          vsync: const TestVSync(),
          duration: const Duration(milliseconds: 900),
          value: 0.0,
        );
        await tester.pumpWidget(makeTestableWidget(animation: controller));
        await tester.pumpAndSettle();
        controller.value = 1.0;
        await tester.pumpWidget(makeTestableWidget(animation: controller));
        await tester.pump();
        final progressIndicator = tester.widget<LinearProgressIndicator>(
          find.byType(LinearProgressIndicator),
        );
        expect(progressIndicator.value, 1.0);
        controller.dispose();
      },
    );
  });
}