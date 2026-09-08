import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:smart_service_market_place/core/errors/failure.dart';
import 'package:smart_service_market_place/features/auth/model/models/user_model.dart';
import 'package:smart_service_market_place/features/auth/model/repos/auth_repo.dart';
import 'package:smart_service_market_place/features/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:smart_service_market_place/features/profile/model/models/address.dart';
import 'package:smart_service_market_place/features/profile/model/models/rating.dart';
import 'package:smart_service_market_place/features/profile/model/models/statistics.dart';
import 'package:smart_service_market_place/features/profile/model/models/user_information.dart';
import 'package:smart_service_market_place/features/services/model/repos/service_repo.dart';
import 'package:smart_service_market_place/features/services/view/provider_details_view.dart';
import 'package:smart_service_market_place/features/services/view/widgets/make_order_dialog.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

class MockServicesRepo extends Mock implements ServicesRepo {}

void main() {
  late MockAuthRepo authRepo;
  late MockServicesRepo servicesRepo;
  late AuthCubit authCubit;
  final user = UserModel(
    id: 11,
    email: 'customer@example.com',
    name: 'Test Customer',
    token: 'customer-token',
    role: 'user',
  );
  final providerInformation = UserInformation(
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

  setUp(() {
    authRepo = MockAuthRepo();
    authCubit = AuthCubit(authRepo: authRepo);
    authCubit.emit(AuthSuccess(user: user));

    servicesRepo = MockServicesRepo();
    when(
      () => servicesRepo.getProviderById(id: '7', token: 'customer-token'),
    ).thenAnswer(
      (_) async => Right<Failure, UserInformation>(providerInformation),
    );

    if (GetIt.I.isRegistered<ServicesRepo>()) {
      GetIt.I.unregister<ServicesRepo>();
    }
    GetIt.I.registerSingleton<ServicesRepo>(servicesRepo);
  });

  tearDown(() async {
    await authCubit.close();
    if (GetIt.I.isRegistered<ServicesRepo>()) {
      GetIt.I.unregister<ServicesRepo>();
    }
  });

  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, __) => BlocProvider<AuthCubit>.value(
        value: authCubit,
        child: MaterialApp(home: const ProviderDetailsView(id: 7)),
      ),
    );
  }

  Future<void> pumpProviderDetailsView(WidgetTester tester) async {
    tester.view
      ..physicalSize = const Size(1000, 1600)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();
    });
  }

  group('ProviderDetailsView integration', () {
    testWidgets('loads the provider details and renders the profile info', (
      tester,
    ) async {
      await pumpProviderDetailsView(tester);

      expect(find.byType(ProviderDetailsView), findsOneWidget);
      expect(find.text('الملف الشخصي'), findsOneWidget);
      expect(find.text('Jane Provider'), findsOneWidget);
      expect(find.text('jane@example.com'), findsOneWidget);
      expect(find.text('0123456789'), findsOneWidget);
      expect(find.text('Cairo'), findsOneWidget);
      expect(find.text('Five years of experience'), findsOneWidget);
      expect(find.text('عمل اوردر'), findsOneWidget);
      verify(
        () => servicesRepo.getProviderById(id: '7', token: 'customer-token'),
      ).called(1);
    });

    testWidgets('shows the provider error message when the fetch fails', (
      tester,
    ) async {
      when(
        () => servicesRepo.getProviderById(id: '7', token: 'customer-token'),
      ).thenAnswer(
        (_) async => Left<Failure, UserInformation>(
          Failure(message: 'Provider not found'),
        ),
      );

      await pumpProviderDetailsView(tester);

      expect(find.text('Provider not found'), findsOneWidget);
    });

    testWidgets('opens the make order dialog when the order button is tapped', (
      tester,
    ) async {
      await pumpProviderDetailsView(tester);
      await tester.ensureVisible(find.text('عمل اوردر'));
      await tester.tap(find.text('عمل اوردر'));
      await tester.pumpAndSettle();

      expect(find.byType(MakeOrderDialog), findsOneWidget);
      expect(find.text('رقم الهاتف'), findsOneWidget);
      expect(find.text('الوصف'), findsOneWidget);
      expect(find.text(' تأكيد الطلب'), findsOneWidget);
    });
  });
}
