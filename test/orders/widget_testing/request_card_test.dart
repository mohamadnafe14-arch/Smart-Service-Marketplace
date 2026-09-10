import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/orders/model/models/order_model.dart';
import 'package:smart_service_market_place/features/orders/view/widgets/request_card.dart';

void main() {
  // Helper to pump RequestCard wrapped with ScreenUtilInit (required because
  // the widget uses .w / .h / .r / .sp extensions from flutter_screenutil).
  Future<void> pumpRequestCard(
    WidgetTester tester, {
    required OrderModel order,
  }) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          home: Scaffold(
            body: RequestCard(order: order),
          ),
        ),
      ),
    );
    // Let ScreenUtilInit finish its first build.
    await tester.pumpAndSettle();
  }

  OrderModel buildOrder({
    String status = "pending",
    String userName = "Ahmed Ali",
    String phoneUser = "01000000000",
    String description = "Fix the AC unit",
    String updatedAt = "2025-01-01",
  }) {
    return OrderModel(
      userName: userName,
      phoneUser: phoneUser,
      description: description,
      status: status,
      updatedAt: updatedAt,
      id: 1,
      userId: 1,
      providerId: 1,
      providerName: "Provider Name",
      rating: 4.5,
    );
  }

  group('RequestCard', () {
    testWidgets('renders user name, phone, description, status and updatedAt',
        (tester) async {
      final order = buildOrder();

      await pumpRequestCard(tester, order: order);

      expect(find.text(order.userName), findsOneWidget);
      expect(find.text(order.phoneUser), findsOneWidget);
      expect(find.text(order.description), findsOneWidget);
      expect(find.text(order.status), findsOneWidget);
      expect(find.text("اخر تحديث: ${order.updatedAt}"), findsOneWidget);
    });

    testWidgets('shows Accept and Reject buttons when status is pending',
        (tester) async {
      final order = buildOrder(status: "pending");

      await pumpRequestCard(tester, order: order);

      expect(find.text("Accept"), findsOneWidget);
      expect(find.text("Reject"), findsOneWidget);
    });

    testWidgets('hides Accept and Reject buttons when status is not pending',
        (tester) async {
      final order = buildOrder(status: "completed");

      await pumpRequestCard(tester, order: order);

      expect(find.text("Accept"), findsNothing);
      expect(find.text("Reject"), findsNothing);
    });

    testWidgets('tapping Accept shows success snackbar', (tester) async {
      final order = buildOrder(status: "pending");

      await pumpRequestCard(tester, order: order);

      await tester.tap(find.text("Accept"));
      await tester.pump(); // start the animation
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text("Order accepted successfully"), findsOneWidget);
    });

    testWidgets('tapping Reject shows success snackbar', (tester) async {
      final order = buildOrder(status: "pending");

      await pumpRequestCard(tester, order: order);

      await tester.tap(find.text("Reject"));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text("Order rejected successfully"), findsOneWidget);
    });
  });
}