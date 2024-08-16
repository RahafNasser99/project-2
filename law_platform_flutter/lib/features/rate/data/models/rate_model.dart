import 'package:law_platform_flutter/features/rate/domain/entities/rate.dart';

class RateModel extends Rate {
  RateModel({required super.rateValue});

  factory RateModel.fromJson(Map<String, dynamic> json) => RateModel(
        rateValue: json['rate'],
      );

  Map<String, dynamic> toJson() => {
        'rating': rateValue,
      };
}
