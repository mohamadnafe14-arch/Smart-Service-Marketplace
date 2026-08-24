import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FlutterSecureStorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  Future<String?> readToken() async => await _secureStorage.read(key: "token");
  Future<void> writeToken(String token) async =>
      await _secureStorage.write(key: "token", value: token);
  Future<void> deleteToken() async => await _secureStorage.delete(key: "token");
  Future<void> readRole() async => await _secureStorage.read(key: "role");
  Future<void> writeRole(String role) async =>
      await _secureStorage.write(key: "role", value: role);
}
