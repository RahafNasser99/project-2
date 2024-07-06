import 'package:law_platform_mobile_app/utils/configurations.dart';

class CheckAuthentication {
  bool isAuthenticated() {
    final bool? isAuthenticated = prefs.getBool('isAuthenticated');
    return isAuthenticated ?? false;
  }

  Future<void> storeAuthenticationValue(
      String email, String token) async {
    await prefs.setString('token', token);
    await prefs.setString('email', email);
    await prefs.setBool('isAuthenticated', true);
  }

  String getToken() {
    return prefs.getString('token')!;
  }
}
