import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/orders/view/widgets/order_body.dart';
import 'package:smart_service_market_place/features/orders/view/widgets/order_list.dart';

void main() {
  Widget createTestWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return const MaterialApp(home: Scaffold(body: OrderBody()));
      },
    );
  }

  group('OrderBody widget tests', () {
    testWidgets('renders the page title and scrollable body', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('الطلبات التي تم تقديمها'), findsOneWidget);
      expect(find.byType(CustomScrollView), findsOneWidget);
    });

    testWidgets('contains the OrderList widget inside the body', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(OrderList), findsOneWidget);
    });
  });
}
