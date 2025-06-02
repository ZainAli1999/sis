import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthModel {
  final Timestamp createdAt;
  final String uid;
  final int status;
  final String firstName;
  final String lastName;
  final DateTime dob;
  final String phoneNumber;
  final String address;
  final String cnic;
  final String profileImage;
  final String department;
  final String designation;
  final DateTime joiningDate;
  final int salary;
  final String employmentStatus;
  final List<String> skills;
  final String gender;
  final String reference;
  final String email;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final TimeOfDay graceTime;
  final String company;
  final String cid;
  final List<String> deviceTokens;
  AuthModel({
    required this.createdAt,
    required this.uid,
    required this.status,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.phoneNumber,
    required this.address,
    required this.cnic,
    required this.profileImage,
    required this.department,
    required this.designation,
    required this.joiningDate,
    required this.salary,
    required this.employmentStatus,
    required this.skills,
    required this.gender,
    required this.reference,
    required this.email,
    required this.startTime,
    required this.endTime,
    required this.graceTime,
    required this.company,
    required this.cid,
    required this.deviceTokens,
  });

  AuthModel copyWith({
    Timestamp? createdAt,
    String? uid,
    int? status,
    String? firstName,
    String? lastName,
    DateTime? dob,
    String? phoneNumber,
    String? address,
    String? cnic,
    String? profileImage,
    String? department,
    String? designation,
    DateTime? joiningDate,
    int? salary,
    String? employmentStatus,
    List<String>? skills,
    String? gender,
    String? reference,
    String? email,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    TimeOfDay? graceTime,
    String? company,
    String? cid,
    List<String>? deviceTokens,
  }) {
    return AuthModel(
      createdAt: createdAt ?? this.createdAt,
      uid: uid ?? this.uid,
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dob: dob ?? this.dob,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      cnic: cnic ?? this.cnic,
      profileImage: profileImage ?? this.profileImage,
      department: department ?? this.department,
      designation: designation ?? this.designation,
      joiningDate: joiningDate ?? this.joiningDate,
      salary: salary ?? this.salary,
      employmentStatus: employmentStatus ?? this.employmentStatus,
      skills: skills ?? this.skills,
      gender: gender ?? this.gender,
      reference: reference ?? this.reference,
      email: email ?? this.email,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      graceTime: graceTime ?? this.graceTime,
      company: company ?? this.company,
      cid: cid ?? this.cid,
      deviceTokens: deviceTokens ?? this.deviceTokens,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'uid': uid,
      'status': status,
      'firstName': firstName,
      'lastName': lastName,
      'dob': dob.millisecondsSinceEpoch,
      'phoneNumber': phoneNumber,
      'address': address,
      'cnic': cnic,
      'profileImage': profileImage,
      'department': department,
      'designation': designation,
      'joiningDate': joiningDate.millisecondsSinceEpoch,
      'salary': salary,
      'employmentStatus': employmentStatus,
      'skills': skills,
      'gender': gender,
      'reference': reference,
      'email': email,
      'startTime': startTime.hour * 60 + startTime.minute,
      'endTime': endTime.hour * 60 + endTime.minute,
      'graceTime': graceTime.hour * 60 + graceTime.minute,
      'company': company,
      'cid': cid,
      'deviceTokens': deviceTokens,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      createdAt: map['createdAt'],
      uid: map['uid'] ?? '',
      status: map['status']?.toInt() ?? 0,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      dob: DateTime.fromMillisecondsSinceEpoch(map['dob']),
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      cnic: map['cnic'] ?? '',
      profileImage: map['profileImage'] ?? '',
      department: map['department'] ?? '',
      designation: map['designation'] ?? '',
      joiningDate: DateTime.fromMillisecondsSinceEpoch(map['joiningDate']),
      salary: map['salary']?.toInt() ?? 0,
      employmentStatus: map['employmentStatus'] ?? '',
      skills: List<String>.from(map['skills']),
      gender: map['gender'] ?? '',
      reference: map['reference'] ?? '',
      email: map['email'] ?? '',
      startTime: TimeOfDay(
        hour: (map['startTime']) ~/ 60,
        minute: (map['startTime']) % 60,
      ),
      endTime: TimeOfDay(
        hour: (map['endTime']) ~/ 60,
        minute: (map['endTime']) % 60,
      ),
      graceTime: TimeOfDay(
        hour: (map['graceTime']) ~/ 60,
        minute: (map['graceTime']) % 60,
      ),
      company: map['company'] ?? '',
      cid: map['cid'] ?? '',
      deviceTokens: List<String>.from(map['deviceTokens']),
    );
  }
}
