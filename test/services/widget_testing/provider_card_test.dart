import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/services/model/models/get_provider.dart';
import 'package:smart_service_market_place/features/services/view/widgets/provider_card.dart';

void main() {
  // Helper to wrap the widget with ScreenUtilInit + MaterialApp,
  // since the widget uses .r/.w/.h/.sp extensions.
  Widget createWidgetUnderTest(GetProvider provider) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        home: Scaffold(
          body: ProviderCard(getProvider: provider),
        ),
      ),
    );
  }

  group('ProviderCard', () {
    testWidgets('renders provider name, category, and rating correctly',
        (WidgetTester tester) async {
      final provider = GetProvider(
        name: 'John Doe',
        category: "السباكة",
        rating: 4.5,
      );

      await tester.pumpWidget(createWidgetUnderTest(provider));
      await tester.pumpAndSettle();

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('السباكة'), findsOneWidget);
      expect(find.text('4.5'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward_ios), findsOneWidget);
    });

    testWidgets('shows fallback text when name is null',
        (WidgetTester tester) async {
      final provider = GetProvider(
        name: null,
        category: "السباكة",
        rating: 4.0,
      );

      await tester.pumpWidget(createWidgetUnderTest(provider));
      await tester.pumpAndSettle();

      expect(find.text('لم يتم تحديد الاسم'), findsOneWidget);
    });

    testWidgets('shows fallback text and default avatar when category is null',
        (WidgetTester tester) async {
      final provider = GetProvider(
        name: 'Jane Doe',
        category: null,
        rating: 3.8,
      );

      await tester.pumpWidget(createWidgetUnderTest(provider));
      await tester.pumpAndSettle();

      // Fallback category text appears (used twice: avatar condition & Text widget)
      expect(find.text('لم يتم تحديد الفئة'), findsOneWidget);

      // Default avatar shown instead of Image.asset
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byType(Image), findsNothing);
    });

    testWidgets(
        'shows default avatar when category equals "لم يتم تحديد الفئة"',
        (WidgetTester tester) async {
      final provider = GetProvider(
        name: 'Jane Doe',
        category: 'لم يتم تحديد الفئة',
        rating: 3.8,
      );

      await tester.pumpWidget(createWidgetUnderTest(provider));
      await tester.pumpAndSettle();

      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byType(Image), findsNothing);
    });

    testWidgets('shows Image.asset when category is a valid value',
        (WidgetTester tester) async {
      final provider = GetProvider(
        name: 'Jane Doe',
        category: "السباكة",
        rating: 3.8,
      );

      await tester.pumpWidget(createWidgetUnderTest(provider));
      await tester.pumpAndSettle();

      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(CircleAvatar), findsNothing);
    });

    testWidgets('is tappable (GestureDetector present)',
        (WidgetTester tester) async {
      final provider = GetProvider(
        name: 'John Doe',
        category: "السباكة",
        rating: 4.5,
      );

      await tester.pumpWidget(createWidgetUnderTest(provider));
      await tester.pumpAndSettle();

      final gestureFinder = find.byType(GestureDetector);
      expect(gestureFinder, findsOneWidget);

      // Should not throw, even though onTap currently has a TODO/no-op
      await tester.tap(gestureFinder);
      await tester.pumpAndSettle();
    });
  });
}