class ChatContactModel {
  final String profilePic;
  final String contactId;
  final String senderId;
  final String receiverId;
  final DateTime timeSent;
  final String lastMessage;
  final List<String> uids;
  ChatContactModel({
    required this.profilePic,
    required this.contactId,
    required this.senderId,
    required this.receiverId,
    required this.timeSent,
    required this.lastMessage,
    required this.uids,
  });

  ChatContactModel copyWith({
    String? profilePic,
    String? contactId,
    String? senderId,
    String? receiverId,
    DateTime? timeSent,
    String? lastMessage,
    List<String>? uids,
  }) {
    return ChatContactModel(
      profilePic: profilePic ?? this.profilePic,
      contactId: contactId ?? this.contactId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      timeSent: timeSent ?? this.timeSent,
      lastMessage: lastMessage ?? this.lastMessage,
      uids: uids ?? this.uids,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profilePic': profilePic,
      'contactId': contactId,
      'senderId': senderId,
      'receiverId': receiverId,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
      'uids': uids,
    };
  }

  factory ChatContactModel.fromMap(Map<String, dynamic> map) {
    return ChatContactModel(
      profilePic: map['profilePic'] ?? '',
      contactId: map['contactId'] ?? '',
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      lastMessage: map['lastMessage'] ?? '',
      uids: List<String>.from(map['uids']),
    );
  }
}
