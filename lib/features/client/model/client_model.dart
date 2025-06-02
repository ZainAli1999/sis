import 'package:cloud_firestore/cloud_firestore.dart';

class ClientModel {
  final Timestamp createdAt;
  final String uid;
  final int status;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String cnic;
  final String profileImage;
  final String gender;
  final String email;
  ClientModel({
    required this.createdAt,
    required this.uid,
    required this.status,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.cnic,
    required this.profileImage,
    required this.gender,
    required this.email,
  });

  ClientModel copyWith({
    Timestamp? createdAt,
    String? uid,
    int? status,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? cnic,
    String? profileImage,
    String? gender,
    String? email,
  }) {
    return ClientModel(
      createdAt: createdAt ?? this.createdAt,
      uid: uid ?? this.uid,
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      cnic: cnic ?? this.cnic,
      profileImage: profileImage ?? this.profileImage,
      gender: gender ?? this.gender,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'uid': uid,
      'status': status,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'cnic': cnic,
      'profileImage': profileImage,
      'gender': gender,
      'email': email,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      createdAt: map['createdAt'],
      uid: map['uid'] ?? '',
      status: map['status']?.toInt() ?? 0,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      cnic: map['cnic'] ?? '',
      profileImage: map['profileImage'] ?? '',
      gender: map['gender'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
