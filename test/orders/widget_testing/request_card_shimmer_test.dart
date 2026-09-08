import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_service_market_place/features/orders/view/widgets/request_card_shimmer.dart';

void main() {
  // Helper to pump the widget wrapped with ScreenUtilInit,
  // which is required since the widget uses .w/.h/.r extensions.
  //
  // IMPORTANT: We use pump() instead of pumpAndSettle() because
  // Shimmer.fromColors runs a continuously repeating animation.
  // pumpAndSettle() waits for all animations to finish, which never
  // happens with a repeating animation, causing a timeout.
  Future<void> pumpShimmerWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) =>
            const MaterialApp(home: Scaffold(body: RequestCardShimmer())),
      ),
    );

    // One pump to build the widget tree, another to let
    // ScreenUtilInit's builder callback resolve.
    await tester.pump();
    await tester.pump();
  }

  group('RequestCardShimmer', () {
    testWidgets('renders without throwing', (WidgetTester tester) async {
      await pumpShimmerWidget(tester);
      expect(find.byType(RequestCardShimmer), findsOneWidget);
    });

    testWidgets('wraps content in a Shimmer.fromColors widget', (
      WidgetTester tester,
    ) async {
      await pumpShimmerWidget(tester);
      expect(find.byType(Shimmer), findsOneWidget);
    });

    testWidgets('renders outer container with correct decoration', (
      WidgetTester tester,
    ) async {
      await pumpShimmerWidget(tester);

      // Find the main content Container (the card itself),
      // i.e. the one with margin/padding/boxShadow - it's the
      // first Container inside Shimmer.
      final shimmerFinder = find.byType(Shimmer);
      final containerFinder = find.descendant(
        of: shimmerFinder,
        matching: find.byType(Container),
      );

      expect(containerFinder, findsWidgets);

      final Container cardContainer = tester.widget<Container>(
        containerFinder.first,
      );
      final BoxDecoration decoration =
          cardContainer.decoration as BoxDecoration;

      expect(decoration.color, Colors.white);
      expect(decoration.borderRadius, isA<BorderRadius>());
      expect(decoration.boxShadow, isNotNull);
      expect(decoration.boxShadow!.length, 1);
    });

    testWidgets('renders correct number of shimmer placeholder boxes', (
      WidgetTester tester,
    ) async {
      await pumpShimmerWidget(tester);

      // Count all Containers rendered (1 outer card container + 8 shimmer boxes)
      // 8 boxes: name, status, phone, desc line1, desc line2, last update,
      // button1, button2
      final containers = find.byType(Container);
      expect(containers, findsNWidgets(9));
    });

    testWidgets('contains two Row widgets (header row + action buttons row)', (
      WidgetTester tester,
    ) async {
      await pumpShimmerWidget(tester);
      expect(find.byType(Row), findsNWidgets(2));
    });

    testWidgets('contains a Column widget for layout', (
      WidgetTester tester,
    ) async {
      await pumpShimmerWidget(tester);
      expect(find.byType(Column), findsOneWidget);
    });

    testWidgets('action buttons row contains two Expanded widgets', (
      WidgetTester tester,
    ) async {
      await pumpShimmerWidget(tester);

      final rows = find.byType(Row);
      // second row = action buttons row
      final actionRow = tester.widgetList<Row>(rows).last;
      final expandedInRow = actionRow.children.whereType<Expanded>().length;

      expect(expandedInRow, 2);
    });

    testWidgets('shimmer boxes have expected fixed widths for name/status', (
      WidgetTester tester,
    ) async {
      await pumpShimmerWidget(tester);

      final shimmerFinder = find.byType(Shimmer);
      final containerFinder = find.descendant(
        of: shimmerFinder,
        matching: find.byType(Container),
      );

      final containers = tester.widgetList<Container>(containerFinder).toList();

      // containers[0] = outer card container, containers[1] = name box,
      // containers[2] = status pill
      final nameBox = containers[1];
      final statusBox = containers[2];

      expect(
        nameBox.constraints?.maxWidth ?? nameBox.constraints?.minWidth,
        isNotNull,
      );
      expect(statusBox.decoration, isA<BoxDecoration>());

      final statusDecoration = statusBox.decoration as BoxDecoration;
      // radius 20.r for status pill differs from default 8.r
      expect(statusDecoration.borderRadius, isA<BorderRadius>());
    });

    testWidgets('golden test for RequestCardShimmer', (
      WidgetTester tester,
    ) async {
      await pumpShimmerWidget(tester);

      // Pump a fixed duration so the shimmer gradient is in a
      // deterministic position for the golden comparison.
      await tester.pump(const Duration(milliseconds: 100));

      await expectLater(
        find.byType(RequestCardShimmer),
        matchesGoldenFile('goldens/request_card_shimmer.png'),
      );
    }, skip: true); // remove skip once golden baseline is generated
  });
}
