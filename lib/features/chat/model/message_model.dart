import 'package:sis/core/enums/message_enum.dart';

class MessageModel {
  final String senderId;
  final String receiverId;
  final String text;
  final String file;
  final MessageEnum type;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;
  final int status;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.file,
    required this.type,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
    required this.status,
  });

  MessageModel copyWith({
    String? senderId,
    String? receiverId,
    String? text,
    String? file,
    MessageEnum? type,
    DateTime? timeSent,
    String? messageId,
    bool? isSeen,
    int? status,
  }) {
    return MessageModel(
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      text: text ?? this.text,
      file: file ?? this.file,
      type: type ?? this.type,
      timeSent: timeSent ?? this.timeSent,
      messageId: messageId ?? this.messageId,
      isSeen: isSeen ?? this.isSeen,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'file': file,
      'type': type.type,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'messageId': messageId,
      'isSeen': isSeen,
      'status': status,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      text: map['text'] ?? '',
      file: map['file'] ?? '',
      type: (map['type'] as String).toEnum(),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      messageId: map['messageId'] ?? '',
      isSeen: map['isSeen'] ?? false,
      status: map['status']?.toInt() ?? 0,
    );
  }
}
