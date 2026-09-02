import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_service_market_place/core/errors/failure.dart';
import 'package:smart_service_market_place/core/utils/app_router.dart';
import 'package:smart_service_market_place/features/auth/model/repos/auth_repo.dart';
import 'package:smart_service_market_place/features/auth/view/auth_view.dart';
import 'package:smart_service_market_place/features/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:smart_service_market_place/features/profile/model/models/address.dart';
import 'package:smart_service_market_place/features/profile/model/models/rating.dart';
import 'package:smart_service_market_place/features/profile/model/models/statistics.dart';
import 'package:smart_service_market_place/features/profile/model/models/user_information.dart';
import 'package:smart_service_market_place/features/profile/model/models/user_update.dart';
import 'package:smart_service_market_place/features/profile/model/repos/profile_repo.dart';
import 'package:smart_service_market_place/features/profile/view/edit_provider_profile_view.dart';
import 'package:smart_service_market_place/features/profile/viewmodel/profile_cubit/profile_cubit.dart';

class MockProfileRepo extends Mock implements ProfileRepo {}

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late MockProfileRepo profileRepo;
  late ProfileCubit profileCubit;
  late AuthCubit authCubit;

  const token = 'provider_token';
  final currentProvider = UserInformation(
    id: 2,
    name: 'Current Provider',
    email: 'provider@example.com',
    phone: '01012345678',
    createdSince: '2026-01-01',
    address: Address(
      city: 'Cairo',
      street: 'Nile Street',
      addressInDetails: 'Building 1',
    ),
    statistics: Statistics(totalNumberOfOrders: 10, finishedOrders: 8),
    rating: Rating(rate: 4.8, count: 12),
    category: 'السباكة',
    experience: '5 years',
  );

  setUp(() {
    profileRepo = MockProfileRepo();
    profileCubit = ProfileCubit(profileRepo);
    profileCubit.emit(ProfileSuccess(currentProvider));
    authCubit = AuthCubit(authRepo: MockAuthRepo());
    AppRouter.router.go(AppRouter.authRoute);
  });

  tearDown(() async {
    await profileCubit.close();
    await authCubit.close();
  });

  Future<void> pumpEditProfile(WidgetTester tester) async {
    tester.view
      ..physicalSize = const Size(1000, 1600)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: authCubit),
            BlocProvider.value(value: profileCubit),
          ],
          child: MaterialApp.router(routerConfig: AppRouter.router),
        ),
      ),
    );
    await tester.pumpAndSettle();
    AppRouter.router.push(AppRouter.editProviderProfileViewRoute, extra: token);
    await tester.pumpAndSettle();
  }

  testWidgets('opens provider edit route with current profile information', (
    tester,
  ) async {
    await pumpEditProfile(tester);

    expect(find.byType(EditProviderProfileView), findsOneWidget);
    expect(find.text('تعديل الملف الشخصي'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(6));
    expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
    expect(find.text('Current Provider'), findsOneWidget);
    expect(find.text('01012345678'), findsOneWidget);
    expect(find.text('5 years'), findsOneWidget);
  });

  testWidgets('selects a category, saves the provider profile, and returns', (
    tester,
  ) async {
    final updatedProvider = currentProvider.copyWith(
      name: 'Updated Provider',
      category: 'البرمجة',
    );
    final expectedUpdate = UserUpdate(
      name: 'Updated Provider',
      phone: '01123456789',
      city: 'Alexandria',
      street: 'Sea Road',
      addressInDetails: 'Building 9',
      category: 'البرمجة',
      experience: '8 years',
    );
    when(
      () => profileRepo.updateUserInformation(
        token: token,
        userUpdate: expectedUpdate,
      ),
    ).thenAnswer((_) async => Right<Failure, UserInformation>(updatedProvider));

    await pumpEditProfile(tester);
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Updated Provider');
    await tester.enterText(fields.at(1), '01123456789');
    await tester.enterText(fields.at(2), 'Alexandria');
    await tester.enterText(fields.at(3), 'Sea Road');
    await tester.enterText(fields.at(4), 'Building 9');
    await tester.ensureVisible(find.byType(DropdownButtonFormField<String>));
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('البرمجة').last);
    await tester.enterText(fields.at(5), '8 years');
    await tester.ensureVisible(find.text('حفظ التغييرات'));
    await tester.tap(find.text('حفظ التغييرات'));
    await tester.pumpAndSettle();

    verify(
      () => profileRepo.updateUserInformation(
        token: token,
        userUpdate: expectedUpdate,
      ),
    ).called(1);
    expect(find.byType(EditProviderProfileView), findsNothing);
    expect(find.byType(AuthView), findsOneWidget);
  });
}
