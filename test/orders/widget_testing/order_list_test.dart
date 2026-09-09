import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/core/widgets/pagination_widget.dart';
import 'package:smart_service_market_place/features/orders/view/widgets/order_list.dart';
import 'package:smart_service_market_place/features/orders/view/widgets/user_card.dart';

void main() {
  group('OrderList', () {
    Widget buildTestable() {
      return ScreenUtilInit(
        designSize: const Size(375, 812), // match whatever your app uses
        minTextAdapt: true,
        builder: (context, child) {
          return const MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  OrderList(),
                ],
              ),
            ),
          );
        },
      );
    }

    testWidgets('renders 5 UserCard items', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestable());
      await tester.pumpAndSettle();

      expect(find.byType(UserCard), findsNWidgets(5));
    });

    testWidgets('renders a PaginationWidget', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestable());
      await tester.pumpAndSettle();

      expect(find.byType(PaginationWidget), findsOneWidget);
    });

    testWidgets('passes correct order data to the first UserCard',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestable());
      await tester.pumpAndSettle();

      final firstCard =
          tester.widgetList<UserCard>(find.byType(UserCard)).first;

      expect(firstCard.order.providerName, 'Ahmed Services');
      expect(firstCard.order.status, 'active');
      expect(firstCard.order.description, 'AC repair and maintenance');
      expect(firstCard.order.userName, 'John Doe');
      expect(firstCard.order.rating, 4.5);
    });


  });
}