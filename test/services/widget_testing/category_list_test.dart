import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/services/view/widgets/category_item.dart';
import 'package:smart_service_market_place/features/services/view/widgets/category_list.dart';
// ^ adjust import path to wherever CategoryList actually lives

void main() {
  Future<void> pumpCategoryList(WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) =>
            const MaterialApp(home: Scaffold(body: CategoryList())),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('CategoryList', () {
    testWidgets('renders all 5 categories with correct titles', (tester) async {
      await pumpCategoryList(tester);
      expect(find.text('الكل'), findsOneWidget);
      expect(find.text('الكهرباء'), findsOneWidget);
      expect(find.text('البناء'), findsOneWidget);
      expect(find.text('البرمجة'), findsOneWidget);
      expect(find.text('السباكة'), findsOneWidget);
    });

    testWidgets('renders correct icons for each category', (tester) async {
      await pumpCategoryList(tester);

      expect(find.byIcon(Icons.all_inclusive_outlined), findsOneWidget);
      expect(find.byIcon(Icons.electrical_services_outlined), findsOneWidget);
      expect(find.byIcon(Icons.construction_outlined), findsOneWidget);
      expect(find.byIcon(Icons.code_outlined), findsOneWidget);
      expect(find.byIcon(Icons.plumbing_outlined), findsOneWidget);
    });

    testWidgets('renders exactly 5 CategoryItem widgets', (tester) async {
      await pumpCategoryList(tester);

      expect(find.byType(CategoryItem), findsNWidgets(5));
    });

    testWidgets('is horizontally scrollable', (tester) async {
      await pumpCategoryList(tester);

      expect(find.byType(SingleChildScrollView), findsOneWidget);
      final scrollView = tester.widget<SingleChildScrollView>(
        find.byType(SingleChildScrollView),
      );
      expect(scrollView.scrollDirection, Axis.horizontal);
    });

    testWidgets('all items are unselected by default (isSelected == false)', (
      tester,
    ) async {
      await pumpCategoryList(tester);

      final items = tester.widgetList<CategoryItem>(find.byType(CategoryItem));

      for (final item in items) {
        expect(item.isSelected, isFalse);
      }
    });

    testWidgets(
      'each CategoryItem is wrapped in a GestureDetector and is tappable',
      (tester) async {
        await pumpCategoryList(tester);

        expect(find.byType(GestureDetector), findsNWidgets(5));

        // Tapping shouldn't throw even though the onTap logic is a TODO/no-op.
        await tester.tap(find.text('البرمجة'));
        await tester.pump();

        // No state change expected yet since selection logic isn't implemented.
        final items = tester.widgetList<CategoryItem>(
          find.byType(CategoryItem),
        );
        for (final item in items) {
          expect(item.isSelected, isFalse);
        }
      },
    );

    testWidgets('categories are rendered in the correct order', (tester) async {
      await pumpCategoryList(tester);

      final textWidgets = tester
          .widgetList<Text>(find.byType(Text))
          .map((t) => t.data)
          .toList();

      expect(textWidgets, ['الكل', 'الكهرباء', 'البناء', 'البرمجة', 'السباكة']);
    });
  });
}
