import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_market_place/features/profile/view/widgets/statistic_widget.dart';
void main() {
  Widget buildTestable(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // match your app's design size
      builder: (context, _) {
        return MaterialApp(
          home: Scaffold(body: child),
        );
      },
    );
  }
  group('StatisticWidget', () {
    testWidgets('renders title and value texts', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestable(
          const StatisticWidget(title: 'Followers', value: '1.2K'),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('1.2K'), findsOneWidget);
      expect(find.text('Followers'), findsOneWidget);
    });
    testWidgets('value text has correct style', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestable(
          const StatisticWidget(title: 'Posts', value: '42'),
        ),
      );
      await tester.pumpAndSettle();
      final valueTextWidget = tester.widget<Text>(find.text('42'));
      expect(valueTextWidget.style?.fontWeight, FontWeight.bold);
      expect(valueTextWidget.style?.color, Colors.blue);
    });
    testWidgets('title text is centered and has correct weight',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestable(
          const StatisticWidget(title: 'Likes', value: '99+'),
        ),
      );
      await tester.pumpAndSettle();
      final titleTextWidget = tester.widget<Text>(find.text('Likes'));
      expect(titleTextWidget.textAlign, TextAlign.center);
      expect(titleTextWidget.style?.fontWeight, FontWeight.w500);
    });
    testWidgets('container is circular with white color and shadow',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestable(
          const StatisticWidget(title: 'Views', value: '3.4K'),
        ),
      );
      await tester.pumpAndSettle();
      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.shape, BoxShape.circle);
      expect(decoration.color, Colors.white);
      expect(decoration.boxShadow, isNotNull);
      expect(decoration.boxShadow!.length, 1);
    });
    testWidgets('SizedBox has square dimensions', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestable(
          const StatisticWidget(title: 'Shares', value: '7'),
        ),
      );
      await tester.pumpAndSettle();
      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
      expect(sizedBox.width, sizedBox.height);
    });
    testWidgets('renders correctly with empty strings',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestable(
          const StatisticWidget(title: '', value: ''),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(StatisticWidget), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(2));
    });
    testWidgets('renders correctly with long text (overflow handling)',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestable(
          const StatisticWidget(
            title: 'A very long title that might overflow the circle',
            value: '999999999',
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(StatisticWidget), findsOneWidget);
    });
  });
}