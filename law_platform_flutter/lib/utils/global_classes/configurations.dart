// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:law_platform_flutter/utils/global_classes/check_authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

InternetConnectionChecker internetConnectionChecker =
    InternetConnectionChecker();

CheckAuthentication checkAuthentication = CheckAuthentication();

late SharedPreferences prefs;

const BASE_URL = 'http://192.168.43.59:8000';

Dio dio = Dio(BaseOptions(
  baseUrl: BASE_URL,
  followRedirects: false,
  maxRedirects: 2,
  headers: {'Accept': 'application/json'},
  connectTimeout: const Duration(milliseconds: 10000),
  receiveTimeout: const Duration(milliseconds: 10000),
  validateStatus: (status) {
    return status != null && status >= 200 && status < 400;
  },
));
