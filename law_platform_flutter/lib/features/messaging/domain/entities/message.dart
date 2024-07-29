abstract class Message {
  final int id;
  final String messageText;
  final DateTime messageDate;

  Message({
    required this.id,
    required this.messageText,
    required this.messageDate,
  });
}
