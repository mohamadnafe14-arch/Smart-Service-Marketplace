import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/services/view/widgets/provider_card_shimmer.dart';

void main() {
  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MaterialApp(
          home: Scaffold(
            body: ProviderCardShimmer(),
          ),
        );
      },
    );
  }

  group('ProviderCardShimmer Widget Tests', () {
    testWidgets(
      'should render ProviderCardShimmer successfully',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.byType(ProviderCardShimmer), findsOneWidget);
      },
    );

    testWidgets(
      'should render Card',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.byType(Card), findsOneWidget);
      },
    );

    testWidgets(
      'should render Row inside the card',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.byType(Row), findsAtLeastNWidgets(2));
      },
    );

    testWidgets(
      'should render skeleton containers',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        // Avatar
        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is Container &&
                widget.constraints?.maxWidth == 60.w,
          ),
          findsAtLeastNWidgets(1),
        );

        // Other skeleton containers
        expect(
          find.byType(Container),
          findsAtLeastNWidgets(5),
        );
      },
    );

    testWidgets(
      'should have no overflow',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pump();

        expect(tester.takeException(), isNull);
      },
    );
  });
}