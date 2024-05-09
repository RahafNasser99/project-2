// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

InternetConnectionChecker internetConnectionChecker =
    InternetConnectionChecker();

const BASE_URL = '';

Dio dio = Dio(BaseOptions(
  baseUrl: BASE_URL,
  contentType: 'application/json',
));
