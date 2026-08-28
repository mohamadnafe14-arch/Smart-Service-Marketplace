import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_service_market_place/core/errors/failure.dart';
import 'package:smart_service_market_place/core/services/dio_service.dart';
import 'package:smart_service_market_place/core/services/flutter_secure_storage_service.dart';
import 'package:smart_service_market_place/core/services/google_sign_in_service.dart';
import 'package:smart_service_market_place/features/auth/model/repos/auth_repo_impl.dart';
class MockGoogleSignInService extends Mock implements GoogleSignInService {}
class MockDioService extends Mock implements DioService {}
class MockFlutterSecureStorageService extends Mock
    implements FlutterSecureStorageService {}
class FakeGoogleCredentials {
  final String token;
  final String email;
  FakeGoogleCredentials({required this.token, required this.email});
}
class FakeRequestOptions extends Fake implements RequestOptions {}
void main() {
  late MockGoogleSignInService googleSignInService;
  late MockDioService dioService;
  late MockFlutterSecureStorageService secureStorageService;
  late AuthRepoImpl authRepo;
  setUpAll(() {
    registerFallbackValue(FakeRequestOptions());
  });
  setUp(() {
    googleSignInService = MockGoogleSignInService();
    dioService = MockDioService();
    secureStorageService = MockFlutterSecureStorageService();
    authRepo = AuthRepoImpl(
      googleSignInService: googleSignInService,
      dioService: dioService,
      flutterSecureStorageService: secureStorageService,
    );
  });
  final userJson = {
    "id": 1,
    "name": "Test User",
    "email": "test@example.com",
  };
  Response<dynamic> buildResponse({
    required int statusCode,
    required Map<String, dynamic> data,
    String path = "/api/test",
  }) {
    return Response(
      requestOptions: RequestOptions(path: path),
      statusCode: statusCode,
      data: data,
    );
  }
  DioException buildDioException({
    required String path,
    int? statusCode,
  }) {
    return DioException(
      requestOptions: RequestOptions(path: path),
      response: statusCode != null
          ? Response(
              requestOptions: RequestOptions(path: path),
              statusCode: statusCode,
              data: {"message": "server error"},
            )
          : null,
      type: DioExceptionType.badResponse,
    );
  }
  group('login', () {
    const email = "test@example.com";
    const password = "123456";
    test(
      'returns Right(UserModel) and stores token when statusCode is 200',
      () async {
        final responseData = {
          "message": "success",
          "data": {
            "user": userJson,
            "access_token": "abc123",
          },
        };
        when(
          () => dioService.post(
            path: "/api/login",
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer(
          (_) async => buildResponse(statusCode: 200, data: responseData),
        );
        when(() => secureStorageService.writeToken(any()))
            .thenAnswer((_) async {});
        final result = await authRepo.login(email: email, password: password);
        expect(result.isRight(), true);
        result.match(
          (l) => fail('expected Right, got Left: ${l.message}'),
          (user) {
            expect(user.token, "abc123");
          },
        );
        verify(() => secureStorageService.writeToken("abc123")).called(1);
      },
    );
    test(
      'returns Left(Failure) with server message when statusCode is not 200',
      () async {
        final responseData = {"message": "بيانات الدخول غير صحيحة"};

        when(
          () => dioService.post(
            path: "/api/login",
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer(
          (_) async => buildResponse(statusCode: 401, data: responseData),
        );

        final result = await authRepo.login(email: email, password: password);

        expect(result.isLeft(), true);
        result.match(
          (l) => expect(l.message, "بيانات الدخول غير صحيحة"),
          (r) => fail('expected Left, got Right'),
        );
        verifyNever(() => secureStorageService.writeToken(any()));
      },
    );
    test('returns Left(ServerFailuer) when a DioException is thrown',
        () async {
      when(
        () => dioService.post(
          path: "/api/login",
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(buildDioException(path: "/api/login", statusCode: 500));
      final result = await authRepo.login(email: email, password: password);
      expect(result.isLeft(), true);
      result.match(
        (l) => expect(l, isA<Failure>()),
        (r) => fail('expected Left, got Right'),
      );
    });
    test('returns Left(Failure) when an unexpected exception is thrown',
        () async {
      when(
        () => dioService.post(
          path: "/api/login",
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(Exception('unexpected'));
      final result = await authRepo.login(email: email, password: password);
      expect(result.isLeft(), true);
    });
  });
  group('register', () {
    const email = "test@example.com";
    const password = "123456";
    const name = "Test User";
    test(
      'returns Right(UserModel) and stores token when statusCode is 201',
      () async {
        when(() => secureStorageService.readRole())
            .thenAnswer((_) async => "customer");
        final responseData = {
          "message": "success",
          "data": {
            "user": userJson,
            "access_token": "reg-token",
          },
        };
        when(
          () => dioService.post(
            path: "/api/register",
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer(
          (_) async => buildResponse(statusCode: 201, data: responseData),
        );
        when(() => secureStorageService.writeToken(any()))
            .thenAnswer((_) async {});
        final result = await authRepo.register(
          email: email,
          password: password,
          name: name,
        );
        expect(result.isRight(), true);
        result.match(
          (l) => fail('expected Right, got Left: ${l.message}'),
          (user) => expect(user.token, "reg-token"),
        );
        verify(() => secureStorageService.writeToken("reg-token")).called(1);
      },
    );
    test('returns Left(Failure) when statusCode is not 201', () async {
      when(() => secureStorageService.readRole())
          .thenAnswer((_) async => "customer");
      final responseData = {"message": "البريد الالكتروني مستخدم من قبل"};
      when(
        () => dioService.post(
          path: "/api/register",
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => buildResponse(statusCode: 422, data: responseData),
      );
      final result = await authRepo.register(
        email: email,
        password: password,
        name: name,
      );
      expect(result.isLeft(), true);
      result.match(
        (l) => expect(l.message, "البريد الالكتروني مستخدم من قبل"),
        (r) => fail('expected Left, got Right'),
      );
    });
    test('returns Left(ServerFailuer) when DioException is thrown', () async {
      when(() => secureStorageService.readRole())
          .thenAnswer((_) async => "customer");
      when(
        () => dioService.post(
          path: "/api/register",
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(buildDioException(path: "/api/register", statusCode: 500));
      final result = await authRepo.register(
        email: email,
        password: password,
        name: name,
      );
      expect(result.isLeft(), true);
    });
  });
  group('getCurrentUser', () {
    test('returns Left(Failure "User Not Found") when no token is stored',
        () async {
      when(() => secureStorageService.readToken())
          .thenAnswer((_) async => null);
      final result = await authRepo.getCurrentUser();
      expect(result.isLeft(), true);
      result.match(
        (l) => expect(l.message, "User Not Found"),
        (r) => fail('expected Left, got Right'),
      );
      verifyNever(
        () => dioService.get(
          path: any(named: 'path'),
          headers: any(named: 'headers'),
        ),
      );
    });
    test('returns Right(UserModel) when token exists and request succeeds',
        () async {
      when(() => secureStorageService.readToken())
          .thenAnswer((_) async => "stored-token");
      final responseData = {
        "message": "success",
        "data": {"user": userJson},
      };
      when(
        () => dioService.get(
          path: "/api/getUser",
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => buildResponse(statusCode: 200, data: responseData),
      );
      final result = await authRepo.getCurrentUser();
      expect(result.isRight(), true);
      result.match(
        (l) => fail('expected Right, got Left: ${l.message}'),
        (user) => expect(user.token, "stored-token"),
      );
    });
    test('returns Left(Failure) when request fails with non-200 status',
        () async {
      when(() => secureStorageService.readToken())
          .thenAnswer((_) async => "stored-token");

      final responseData = {"message": "غير مصرح"};

      when(
        () => dioService.get(
          path: "/api/getUser",
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => buildResponse(statusCode: 401, data: responseData),
      );
      final result = await authRepo.getCurrentUser();
      expect(result.isLeft(), true);
      result.match(
        (l) => expect(l.message, "غير مصرح"),
        (r) => fail('expected Left, got Right'),
      );
    });
    test('returns Left(ServerFailuer) when DioException is thrown', () async {
      when(() => secureStorageService.readToken())
          .thenAnswer((_) async => "stored-token");
      when(
        () => dioService.get(
          path: "/api/getUser",
          headers: any(named: 'headers'),
        ),
      ).thenThrow(buildDioException(path: "/api/getUser", statusCode: 500));
      final result = await authRepo.getCurrentUser();
      expect(result.isLeft(), true);
    });
  });
  group('logout', () {
    test('returns Right(null) and deletes token when statusCode is 200',
        () async {
      when(() => secureStorageService.readToken())
          .thenAnswer((_) async => "stored-token");
      when(
        () => dioService.delete(
          path: "/api/logout",
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => buildResponse(statusCode: 200, data: {"message": "ok"}),
      );
      when(() => secureStorageService.deleteToken()).thenAnswer((_) async {});
      final result = await authRepo.logout();
      expect(result.isRight(), true);
      verify(() => secureStorageService.deleteToken()).called(1);
    });
    test('returns Left(Failure) when statusCode is not 200', () async {
      when(() => secureStorageService.readToken())
          .thenAnswer((_) async => "stored-token");
      when(
        () => dioService.delete(
          path: "/api/logout",
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => buildResponse(
          statusCode: 400,
          data: {"message": "حدث خطأ اثناء تسجيل الخروج"},
        ),
      );
      final result = await authRepo.logout();
      expect(result.isLeft(), true);
      result.match(
        (l) => expect(l.message, "حدث خطأ اثناء تسجيل الخروج"),
        (r) => fail('expected Left, got Right'),
      );
      verifyNever(() => secureStorageService.deleteToken());
    });
    test('returns Left(ServerFailuer) when DioException is thrown', () async {
      when(() => secureStorageService.readToken())
          .thenAnswer((_) async => "stored-token");
      when(
        () => dioService.delete(
          path: "/api/logout",
          headers: any(named: 'headers'),
        ),
      ).thenThrow(buildDioException(path: "/api/logout", statusCode: 500));
      final result = await authRepo.logout();
      expect(result.isLeft(), true);
    });
  });
  group('setRole', () {
    test('calls writeRole with the given role', () async {
      when(() => secureStorageService.writeRole(any()))
          .thenAnswer((_) async {});

      await authRepo.setRole("provider");

      verify(() => secureStorageService.writeRole("provider")).called(1);
    });
  });
  group('authWithGoogle', () {
    test('returns Left(Failure) when a generic exception is thrown',
        () async {
      when(() => googleSignInService.signIn())
          .thenThrow(Exception('Google sign-in cancelled'));
      final result = await authRepo.authWithGoogle();
      expect(result.isLeft(), true);
    });
  });
}