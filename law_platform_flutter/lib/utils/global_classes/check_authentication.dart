import 'package:law_platform_flutter/utils/global_classes/configurations.dart';

class CheckAuthentication {
  bool isAuthenticated() {
    final bool? isAuthenticated = prefs.getBool('isAuthenticated');
    return isAuthenticated ?? false;
  }

  Future<void> storeAuthenticationValue(
      int id, String email, String token, String accountType) async {
    await prefs.setInt('id', id);
    await prefs.setString('token', token);
    await prefs.setString('email', email);
    await prefs.setString('accountType', accountType);
    await prefs.setBool('isAuthenticated', true);
  }

  Future<void> destroyAuthenticationValue() async {
    await prefs.clear();
  }

  int getId() {
    return prefs.getInt('id')!;
  }

  String getToken() {
    return prefs.getString('token')!;
  }

  String getAccountType() {
    return prefs.getString('accountType')!;
  }
}
