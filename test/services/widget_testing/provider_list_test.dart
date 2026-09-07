import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/services/view/widgets/provider_list.dart';
import 'package:smart_service_market_place/features/services/view/widgets/provider_card.dart';
import 'package:smart_service_market_place/core/widgets/pagination_widget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ProviderList Widget Tests', () {
    setUp(() {
      // Prevent real asset loading (e.g. Image.asset('.../Provider Category.jpg'))
      // from throwing during tests, since these images don't exist in the test bundle.
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('flutter/assets', (message) async {
        return ByteData(0);
      });
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('flutter/assets', null);
    });

    Widget createTestWidget() {
      return ScreenUtilInit(
        designSize: const Size(375, 812), // match your app's design size in main.dart
        builder: (context, child) {
          return const MaterialApp(
            home: Scaffold(
              body: ProviderList(),
            ),
          );
        },
      );
    }

    testWidgets('renders a ListView and PaginationWidget', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Scoped by key to avoid colliding with any ListView inside ProviderCard.
      expect(find.byKey(const Key('providerListView')), findsOneWidget);
      expect(find.byType(PaginationWidget), findsOneWidget);
    });

    testWidgets('renders at least one ProviderCard with expected data',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.byType(ProviderCard), findsWidgets);

      final providerCard =
          tester.widgetList<ProviderCard>(find.byType(ProviderCard)).first;
      expect(providerCard.getProvider.id, 1);
      expect(providerCard.getProvider.name, "Provider Name");
      expect(providerCard.getProvider.role, "Provider Role");
      expect(providerCard.getProvider.phone, "Provider Phone");
      expect(providerCard.getProvider.category, "لم يتم تحديد الفئة");
      expect(providerCard.getProvider.rating, 4.5);
    });

    testWidgets('displays provider name text on screen', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.text("Provider Name"), findsWidgets);
    });

    testWidgets('PaginationWidget receives correct links', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      final paginationWidget =
          tester.widget<PaginationWidget>(find.byType(PaginationWidget));

      expect(paginationWidget.links.length, 3);
      expect(paginationWidget.links[0].label, '1');
      expect(paginationWidget.links[0].active, true);
      expect(paginationWidget.links[1].active, false);
      expect(paginationWidget.links[2].active, false);
    });

    testWidgets('onPageSelected callback is provided and callable',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      final paginationWidget =
          tester.widget<PaginationWidget>(find.byType(PaginationWidget));

      expect(() => paginationWidget.onPageSelected(2), returnsNormally);
    });

    testWidgets('Column contains an Expanded ListView above PaginationWidget',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();
  
      // Scoped by key to avoid colliding with any Column inside ProviderCard.
      final columnFinder = find.byKey(const Key('providerListColumn'));
      expect(columnFinder, findsOneWidget);

      final column = tester.widget<Column>(columnFinder);
      expect(column.children.length, 2);
      expect(column.children[0], isA<Expanded>());
      expect(column.children[1], isA<PaginationWidget>());
    });
  });
}