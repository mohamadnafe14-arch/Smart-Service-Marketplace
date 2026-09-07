import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/services/view/widgets/provider_card_shimmer.dart';
import 'package:smart_service_market_place/features/services/view/widgets/provider_shimmer_list.dart';

void main() {
  Widget createWidgetUnderTest({
    int itemCount = 5,
  }) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          home: Scaffold(
            body: ProviderShimmerList(
              itemCount: itemCount,
            ),
          ),
        );
      },
    );
  }

  group('ProviderShimmerList Widget Tests', () {
    testWidgets(
      'should render ProviderShimmerList successfully',
      (tester) async {
        await tester.pumpWidget(
          createWidgetUnderTest(),
        );

        expect(
          find.byType(ProviderShimmerList),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'should render 5 shimmer cards by default',
      (tester) async {
        await tester.pumpWidget(
          createWidgetUnderTest(),
        );

        expect(
          find.byType(ProviderCardShimmer),
          findsNWidgets(5),
        );
      },
    );

    testWidgets(
      'should render the correct number of shimmer cards',
      (tester) async {
        await tester.pumpWidget(
          createWidgetUnderTest(itemCount: 3),
        );

        expect(
          find.byType(ProviderCardShimmer),
          findsNWidgets(3),
        );
      },
    );

    testWidgets(
      'should render no shimmer cards when itemCount is zero',
      (tester) async {
        await tester.pumpWidget(
          createWidgetUnderTest(itemCount: 0),
        );

        expect(
          find.byType(ProviderCardShimmer),
          findsNothing,
        );
      },
    );

    testWidgets(
      'should be scrollable',
      (tester) async {
        await tester.pumpWidget(
          createWidgetUnderTest(itemCount: 10),
        );

        expect(
          find.byType(ListView),
          findsOneWidget,
        );

        final listView = tester.widget<ListView>(
          find.byType(ListView),
        );

        expect(
          listView.scrollDirection,
          Axis.vertical,
        );
      },
    );

    testWidgets(
      'should not throw any exception',
      (tester) async {
        await tester.pumpWidget(
          createWidgetUnderTest(),
        );

        await tester.pump();

        expect(
          tester.takeException(),
          isNull,
        );
      },
    );
  });
}
