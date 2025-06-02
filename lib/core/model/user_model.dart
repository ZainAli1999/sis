// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// class UserModel {
//   final String uid;
//   final int status;
//   final String givenName;
//   final String surName;
//   final String cnic;
//   final String phoneNumber;
//   final String adults;
//   final String childs;
//   final String infants;

//   UserModel({
//     required this.uid,
//     required this.status,
//     required this.givenName,
//     required this.surName,
//     required this.cnic,
//     required this.phoneNumber,
//     required this.adults,
//     required this.childs,
//     required this.infants,
//   });

//   UserModel copyWith({
//     String? uid,
//     int? status,
//     String? givenName,
//     String? surName,
//     String? cnic,
//     String? phoneNumber,
//     String? adults,
//     String? childs,
//     String? infants,
//   }) {
//     return UserModel(
//       uid: uid ?? this.uid,
//       status: status ?? this.status,
//       givenName: givenName ?? this.givenName,
//       surName: surName ?? this.surName,
//       cnic: cnic ?? this.cnic,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       adults: adults ?? this.adults,
//       childs: childs ?? this.childs,
//       infants: infants ?? this.infants,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'uid': uid,
//       'status': status,
//       'givenName': givenName,
//       'surName': surName,
//       'cnic': cnic,
//       'phoneNumber': phoneNumber,
//       'adults': adults,
//       'childs': childs,
//       'infants': infants,
//     };
//   }

//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       uid: map['uid'] as String,
//       status: map['status'] as int,
//       givenName: map['givenName'] as String,
//       surName: map['surName'] as String,
//       cnic: map['cnic'] as String,
//       phoneNumber: map['phoneNumber'] as String,
//       adults: map['adults'] as String,
//       childs: map['childs'] as String,
//       infants: map['infants'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory UserModel.fromJson(String source) =>
//       UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'UserModel(uid: $uid, status: $status, givenName: $givenName, surName: $surName, cnic: $cnic, phoneNumber: $phoneNumber, adults: $adults, childs: $childs, infants: $infants)';
//   }

//   @override
//   bool operator ==(covariant UserModel other) {
//     if (identical(this, other)) return true;

//     return other.uid == uid &&
//         other.status == status &&
//         other.givenName == givenName &&
//         other.surName == surName &&
//         other.cnic == cnic &&
//         other.phoneNumber == phoneNumber &&
//         other.adults == adults &&
//         other.childs == childs &&
//         other.infants == infants;
//   }

//   @override
//   int get hashCode {
//     return uid.hashCode ^
//         status.hashCode ^
//         givenName.hashCode ^
//         surName.hashCode ^
//         cnic.hashCode ^
//         phoneNumber.hashCode ^
//         adults.hashCode ^
//         childs.hashCode ^
//         infants.hashCode;
//   }
// }
