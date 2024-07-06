// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

InternetConnectionChecker internetConnectionChecker =
    InternetConnectionChecker();

const BASE_URL = 'http://192.168.43.59:8000';

Dio dio = Dio(BaseOptions(
  baseUrl: BASE_URL,
  followRedirects: true,
  maxRedirects: 2,
  headers: {'Accept': 'application/json'},
  connectTimeout: const Duration(milliseconds: 10000),
  receiveTimeout: const Duration(milliseconds: 10000),
  validateStatus: (status) {
    return status != null && status >= 200 && status < 400;
  },
));
