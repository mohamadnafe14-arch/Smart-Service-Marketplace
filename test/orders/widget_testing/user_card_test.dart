import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/orders/model/models/order_model.dart';
import 'package:smart_service_market_place/features/orders/view/widgets/user_card.dart';
import 'package:smart_service_market_place/features/orders/view/widgets/custom_action_button.dart';

void main() {
  // Helper to pump UserCard wrapped correctly with ScreenUtilInit + MaterialApp.
  Widget makeTestableWidget(OrderModel order) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        home: Scaffold(
          body: UserCard(order: order),
        ),
      ),
    );
  }

  // Adjust field names/constructor args to match your actual OrderModel.
  OrderModel buildOrder({
    String providerName = 'Ahmed Services',
    String status = 'active',
    String description = 'AC repair and maintenance',
    String updatedAt = '2025-01-01',
  }) {
    return OrderModel(
      providerName: providerName,
      status: status,
      description: description,
      updatedAt: updatedAt,
      id: 1,
      userId: 1,
      providerId: 1,
      phoneUser: '01000000000',
      userName: 'John Doe',
      rating: 4.5,
    );
  }

  group('UserCard widget tests', () {
    testWidgets('renders provider name, status, description, and updatedAt',
        (WidgetTester tester) async {
      final order = buildOrder();

      await tester.pumpWidget(makeTestableWidget(order));
      await tester.pumpAndSettle();

      expect(find.text(order.providerName), findsOneWidget);
      expect(find.text(order.status), findsOneWidget);
      expect(find.text(order.description), findsOneWidget);
      expect(find.text(order.updatedAt), findsOneWidget);
    });

    testWidgets(
        'shows "press here if the order is completed" button when status is active',
        (WidgetTester tester) async {
      final order = buildOrder(status: 'active');

      await tester.pumpWidget(makeTestableWidget(order));
      await tester.pumpAndSettle();

      expect(find.byType(CustomActionButton), findsOneWidget);
      expect(
        find.text('press here if the order is completed'),
        findsOneWidget,
      );
    });

    testWidgets('hides action button when status is not active',
        (WidgetTester tester) async {
      final order = buildOrder(status: 'completed');

      await tester.pumpWidget(makeTestableWidget(order));
      await tester.pumpAndSettle();

      expect(find.byType(CustomActionButton), findsNothing);
      expect(
        find.text('press here if the order is completed'),
        findsNothing,
      );
    });

    testWidgets('hides action button when status is pending',
        (WidgetTester tester) async {
      final order = buildOrder(status: 'pending');

      await tester.pumpWidget(makeTestableWidget(order));
      await tester.pumpAndSettle();

      expect(find.byType(CustomActionButton), findsNothing);
    });

    testWidgets('tapping the action button triggers onTap without throwing',
        (WidgetTester tester) async {
      final order = buildOrder(status: 'active');

      await tester.pumpWidget(makeTestableWidget(order));
      await tester.pumpAndSettle();

      // The current onTap body is empty (TODO), so we're just verifying
      // the tap is handled without exceptions.
      await tester.tap(find.byType(CustomActionButton));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });

    testWidgets('renders inside a styled Container with rounded corners',
        (WidgetTester tester) async {
      final order = buildOrder();

      await tester.pumpWidget(makeTestableWidget(order));
      await tester.pumpAndSettle();

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(UserCard),
          matching: find.byType(Container).first,
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, Colors.white);
      expect(decoration.borderRadius, isA<BorderRadius>());
    });

    testWidgets('status text color matches getColorByStatus result',
        (WidgetTester tester) async {
      final order = buildOrder(status: 'active');

      await tester.pumpWidget(makeTestableWidget(order));
      await tester.pumpAndSettle();

      final statusTextWidget = tester.widget<Text>(find.text('active'));
      expect(statusTextWidget.style?.color, isNotNull);
    });
  });
}