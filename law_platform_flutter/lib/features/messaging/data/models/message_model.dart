import 'package:law_platform_flutter/features/messaging/domain/entities/message.dart';
import 'package:law_platform_flutter/utils/global_classes/data.dart';

class MessageModel extends Message {
  MessageModel({
    required super.id,
    required super.messageText,
    required super.messageDate,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json['id'],
        messageText: json['messageText'],
        messageDate: Date(comingDate: json['date']).handleDate(),
      );

  Map<String, dynamic> toJson() => {
        'text': messageText,
        'date': messageDate,
      };
}
