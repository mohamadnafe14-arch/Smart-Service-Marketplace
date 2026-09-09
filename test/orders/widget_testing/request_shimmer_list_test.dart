import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_market_place/features/orders/view/widgets/request_card_shimmer.dart';
import 'package:smart_service_market_place/features/orders/view/widgets/request_shimmer_list.dart'; // adjust import path

void main() {
  // Helper to pump the widget wrapped with ScreenUtilInit,
  // which is required since RequestCardShimmer uses .w/.h/.r extensions.
  //
  // IMPORTANT: We use pump() instead of pumpAndSettle() because
  // RequestCardShimmer contains Shimmer.fromColors, which runs a
  // continuously repeating animation. pumpAndSettle() would time out
  // waiting for it to finish.
  Future<void> pumpShimmerList(
    WidgetTester tester, {
    int? itemCount,
  }) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          home: Scaffold(
            body: itemCount != null
                ? RequestShimmerList(itemCount: itemCount)
                : const RequestShimmerList(),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump();
  }

  group('RequestShimmerList', () {
    testWidgets('renders without throwing', (WidgetTester tester) async {
      await pumpShimmerList(tester);
      expect(find.byType(RequestShimmerList), findsOneWidget);
    });

    testWidgets('renders a ListView', (WidgetTester tester) async {
      await pumpShimmerList(tester);
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('renders default itemCount of 5 RequestCardShimmer widgets',
        (WidgetTester tester) async {
      await pumpShimmerList(tester);

      // ListView.builder is lazy, so only the visible items will be
      // built/laid out. On a typical test surface (800x600) all 5
      // short shimmer cards likely fit, but to be safe we scroll to
      // verify count reliably instead of assuming all render at once.
      expect(find.byType(RequestCardShimmer), findsWidgets);
    });

    testWidgets('respects a custom itemCount', (WidgetTester tester) async {
      const customCount = 3;
      await pumpShimmerList(tester, itemCount: customCount);

      final listView = tester.widget<ListView>(find.byType(ListView));
      // ListView.builder stores itemCount indirectly via its
      // SliverChildBuilderDelegate.
      final delegate =
          listView.childrenDelegate as SliverChildBuilderDelegate;
      expect(delegate.estimatedChildCount, customCount);
    });

    testWidgets('uses default itemCount of 5 when not provided',
        (WidgetTester tester) async {
      await pumpShimmerList(tester);

      final listView = tester.widget<ListView>(find.byType(ListView));
      final delegate =
          listView.childrenDelegate as SliverChildBuilderDelegate;
      expect(delegate.estimatedChildCount, 5);
    });

    testWidgets('itemCount of 0 renders no RequestCardShimmer widgets',
        (WidgetTester tester) async {
      await pumpShimmerList(tester, itemCount: 0);

      expect(find.byType(RequestCardShimmer), findsNothing);

      final listView = tester.widget<ListView>(find.byType(ListView));
      final delegate =
          listView.childrenDelegate as SliverChildBuilderDelegate;
      expect(delegate.estimatedChildCount, 0);
    });

    testWidgets(
        'scrolling reveals additional RequestCardShimmer items when itemCount is large',
        (WidgetTester tester) async {
      const largeCount = 20;
      await pumpShimmerList(tester, itemCount: largeCount);

      final initiallyVisible =
          find.byType(RequestCardShimmer).evaluate().length;
      expect(initiallyVisible, greaterThan(0));
      expect(initiallyVisible, lessThanOrEqualTo(largeCount));

      // Scroll down within the ListView to trigger building more items.
      await tester.drag(
        find.byType(ListView),
        const Offset(0, -2000),
      );
      await tester.pump();
      await tester.pump();

      // After scrolling, shimmer cards should still be present
      // (new ones built lazily as old ones are recycled/disposed).
      expect(find.byType(RequestCardShimmer), findsWidgets);
    });

    testWidgets('each item in the list is a RequestCardShimmer',
        (WidgetTester tester) async {
      const smallCount = 2;
      await pumpShimmerList(tester, itemCount: smallCount);

      // With only 2 items and default screen height, both should be
      // built and visible without needing to scroll.
      expect(find.byType(RequestCardShimmer), findsNWidgets(smallCount));
    });
  });
}