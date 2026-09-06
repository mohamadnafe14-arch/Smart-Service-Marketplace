import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:smart_service_market_place/features/auth/model/models/user_model.dart';
import 'package:smart_service_market_place/features/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:smart_service_market_place/features/profile/model/models/address.dart';
import 'package:smart_service_market_place/features/profile/model/models/rating.dart';
import 'package:smart_service_market_place/features/profile/model/models/statistics.dart';
import 'package:smart_service_market_place/features/profile/model/models/user_information.dart';
import 'package:smart_service_market_place/features/services/view/widgets/make_order_dialog.dart';
import 'package:smart_service_market_place/features/services/view/widgets/provider_details_body.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
  late MockAuthCubit authCubit;
  late UserInformation providerInformation;

  setUp(() {
    authCubit = MockAuthCubit();
    providerInformation = UserInformation(
      name: 'Jane Provider',
      id: 7,
      email: 'jane@example.com',
      phone: '0123456789',
      createdSince: '2022-01-01',
      address: Address(
        city: 'Cairo',
        street: 'Tahrir St',
        addressInDetails: 'Near the square',
      ),
      statistics: Statistics(totalNumberOfOrders: 8, finishedOrders: 5),
      rating: Rating(rate: 4.5, count: 12),
      category: 'السباكة',
      experiences: 'Five years of experience',
    );
  });

  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => BlocProvider<AuthCubit>.value(
        value: authCubit,
        child: MaterialApp(
          home: Scaffold(
            body: ProviderDetailsBody(providerInformation: providerInformation),
          ),
        ),
      ),
    );
  }

  group('ProviderDetailsBody', () {
    testWidgets('renders provider information and order button', (
      tester,
    ) async {
      whenListen(
        authCubit,
        const Stream<AuthState>.empty(),
        initialState: AuthInitial(),
      );

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        expect(find.text('الملف الشخصي'), findsOneWidget);
        expect(find.text('Jane Provider'), findsOneWidget);
        expect(find.text('jane@example.com'), findsOneWidget);
        expect(find.text('0123456789'), findsOneWidget);
        expect(find.text('Cairo'), findsOneWidget);
        expect(find.text('Tahrir St'), findsOneWidget);
        expect(find.text('Near the square'), findsOneWidget);
        expect(find.text('Five years of experience'), findsOneWidget);
        expect(find.text('عمل اوردر'), findsOneWidget);
      });
    });

    testWidgets('renders fallback text for missing optional information', (
      tester,
    ) async {
      providerInformation = UserInformation(
        name: null,
        id: providerInformation.id,
        email: providerInformation.email,
        phone: null,
        createdSince: providerInformation.createdSince,
        address: Address(),
        statistics: providerInformation.statistics,
        rating: providerInformation.rating,
        category: null,
        experiences: null,
      );
      whenListen(
        authCubit,
        const Stream<AuthState>.empty(),
        initialState: AuthInitial(),
      );

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        expect(find.text('لم يتم اضافة الاسم'), findsOneWidget);
        expect(find.text('لم يتم اضافة رقم الهاتف'), findsOneWidget);
        expect(find.text('لم يتم اضافة المدينة'), findsOneWidget);
        expect(find.text('لم يتم اضافة الشارع'), findsOneWidget);
        expect(find.text('لم يتم اضافة العنوان بالتفصيل'), findsOneWidget);
        expect(find.text('لم يتم اضافة التخصص'), findsOneWidget);
        expect(find.text('لم يتم اضافة الخبرة'), findsOneWidget);
      });
    });

    testWidgets('opens the make-order dialog for an authenticated user', (
      tester,
    ) async {
      whenListen(
        authCubit,
        const Stream<AuthState>.empty(),
        initialState: AuthSuccess(
          user: UserModel(
            email: 'user@example.com',
            name: 'User',
            token: 'test-token',
            id: 1,
            role: 'user',
          ),
        ),
      );

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();
        await tester.ensureVisible(find.text('عمل اوردر'));
        await tester.tap(find.text('عمل اوردر'));
        await tester.pumpAndSettle();

        expect(find.byType(MakeOrderDialog), findsOneWidget);
        expect(find.text('رقم الهاتف'), findsOneWidget);
        expect(find.text('الوصف'), findsOneWidget);
        expect(find.text(' تأكيد الطلب'), findsOneWidget);
      });
    });
  });
}
