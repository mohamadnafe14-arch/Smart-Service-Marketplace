import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/splash_body.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/custom_progress_bar.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/three_dots.dart';
void main() {
  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => const MaterialApp(
        home: Scaffold(body: SplashBody()),
      ),
    );
  }
  Future<void> drainSplashTimer(WidgetTester tester) async {
    await tester.pump(const Duration(seconds: 6));
  }
  group('SplashBody Widget Tests', () {
    testWidgets('renders all expected widgets', (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();
        expect(find.byType(Image), findsOneWidget);
        expect(find.text('سوق الخدمات الرقمية'), findsOneWidget);
        expect(find.text('منصة الخدمات المصغرة الذكية'), findsOneWidget);
        expect(find.text('جاري تهيئة المنصة...'), findsOneWidget);
        expect(find.byType(CustomProgressBar), findsOneWidget);
        expect(find.byType(ThreeDots), findsOneWidget);
        await drainSplashTimer(tester);
      });
    });
    testWidgets('has gradient background container', (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();
        final containerFinder = find.byType(Container).first;
        final container = tester.widget<Container>(containerFinder);
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.gradient, isA<LinearGradient>());
        final gradient = decoration.gradient as LinearGradient;
        expect(gradient.colors, [
          const Color(0xff0f2027),
          const Color(0xff203a43),
          const Color(0xff2c5364),
        ]);
        await drainSplashTimer(tester);
      });
    });
    testWidgets('animation controller starts and progresses', (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();
        await tester.pump(const Duration(seconds: 2));
        expect(find.byType(CustomProgressBar), findsOneWidget);
        expect(find.byType(ThreeDots), findsOneWidget);
        await drainSplashTimer(tester);
      });
    });

    testWidgets('does not throw when animation completes and timer fires',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump(const Duration(seconds: 5));
        await tester.pump(const Duration(milliseconds: 100));
        expect(tester.takeException(), isNull);
      });
    });

    testWidgets('disposes animation controller without error',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();
        await drainSplashTimer(tester);
        await tester.pumpWidget(const SizedBox());
        await tester.pump();
        expect(tester.takeException(), isNull);
      });
    });
  });
}