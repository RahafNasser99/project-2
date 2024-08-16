import 'package:law_platform_flutter/utils/global_classes/configurations.dart';

class CheckAuthentication {
  bool isAuthenticated() {
    final bool? isAuthenticated = prefs.getBool('isAuthenticated');
    return isAuthenticated ?? false;
  }

  Future<void> storeAuthenticationValue(int id, String email, String token,
      String accountType, String name, String? image) async {
    await prefs.setInt('id', id);
    await prefs.setString('token', token);
    await prefs.setString('email', email);
    await prefs.setString('accountType', accountType);
    await prefs.setBool('isAuthenticated', true);
    await prefs.setString('name', name);
    await prefs.setString('image', image ?? '');
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

  String getName() {
    return prefs.getString('name')!;
  }

  String getImage() {
    return prefs.getString('image')!;
  }

  String getAccountType() {
    return prefs.getString('accountType')!;
  }
}
