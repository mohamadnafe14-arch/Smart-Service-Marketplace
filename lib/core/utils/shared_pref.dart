import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPreferences? _sharedPreferences;
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
  Future<void> setToken(String token) async{
    await _sharedPreferences?.setString('token', token);
  }
  Future<String?> getToken() async{
    return _sharedPreferences?.getString('token');
  }
}
