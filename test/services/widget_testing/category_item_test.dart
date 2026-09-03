import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/services/model/models/category_model.dart';
import 'package:smart_service_market_place/features/services/view/widgets/category_item.dart';
// ^ adjust the import path above to match where CategoryItem actually lives

void main() {
  // Helper to pump CategoryItem wrapped with ScreenUtilInit,
  // since the widget relies on .h/.w/.r/.sp extensions.
  Future<void> pumpCategoryItem(
    WidgetTester tester, {
    required CategoryModel categoryModel,
    required bool isSelected,
  }) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          home: Scaffold(
            body: CategoryItem(
              categoryModel: categoryModel,
              isSelected: isSelected,
            ),
          ),
        ),
      ),
    );
    // ScreenUtilInit needs a frame to compute sizes.
    await tester.pumpAndSettle();
  }

  final testCategory = CategoryModel(
    title: 'Plumbing',
    icon: Icons.plumbing,
  );
  // ^ adjust constructor args to match your actual CategoryModel fields

  group('CategoryItem', () {
    testWidgets('renders title and icon correctly', (tester) async {
      await pumpCategoryItem(
        tester,
        categoryModel: testCategory,
        isSelected: false,
      );

      expect(find.text('Plumbing'), findsOneWidget);
      expect(find.byIcon(Icons.plumbing), findsOneWidget);
    });

    testWidgets('shows white background when not selected', (tester) async {
      await pumpCategoryItem(
        tester,
        categoryModel: testCategory,
        isSelected: false,
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.color, Colors.white);
    });

    testWidgets('shows blue background when selected', (tester) async {
      await pumpCategoryItem(
        tester,
        categoryModel: testCategory,
        isSelected: true,
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.color, Colors.blue);
    });

    testWidgets('has circular border radius and black border', (tester) async {
      await pumpCategoryItem(
        tester,
        categoryModel: testCategory,
        isSelected: false,
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.borderRadius, BorderRadius.circular(20.r));
      expect(decoration.border, isA<Border>());

      final border = decoration.border as Border;
      expect(border.top.color, Colors.black);
      expect(border.top.width, 2.w);
    });

    testWidgets('text style is bold with correct font size', (tester) async {
      await pumpCategoryItem(
        tester,
        categoryModel: testCategory,
        isSelected: false,
      );

      final textWidget = tester.widget<Text>(find.text('Plumbing'));
      expect(textWidget.style?.fontWeight, FontWeight.bold);
      expect(textWidget.style?.fontSize, 16.sp);
      expect(textWidget.style?.color, Colors.black);
    });

    testWidgets('renders correctly for different category models',
        (tester) async {
      final anotherCategory = CategoryModel(
        title: 'Electrical',
        icon: Icons.electrical_services,
      );

      await pumpCategoryItem(
        tester,
        categoryModel: anotherCategory,
        isSelected: true,
      );

      expect(find.text('Electrical'), findsOneWidget);
      expect(find.byIcon(Icons.electrical_services), findsOneWidget);
    });
  });
}