// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:sis/core/model/user_model.dart';

// part 'user_info_notifier.g.dart';

// @Riverpod(keepAlive: true)
// class UserInfoNotifier extends _$UserInfoNotifier {
//   String? uid;
//   int? status;
//   String? givenName;
//   String? surName;
//   String? cnic;
//   String? phoneNumber;
//   String? adults;
//   String? childs;
//   String? infants;
//   String? verificationId;

//   @override
//   UserModel? build() {
//     return null;
//   }

//   void saveUserInfo({
//     required String uid,
//     required int status,
//     required String givenName,
//     required String surName,
//     required String cnic,
//     required String phoneNumber,
//     required String adults,
//     required String childs,
//     required String infants,
//   }) {
//     this.uid = uid;
//     this.status = status;
//     this.givenName = givenName;
//     this.surName = surName;
//     this.cnic = cnic;
//     this.phoneNumber = phoneNumber;
//     this.adults = adults;
//     this.childs = childs;
//     this.infants = infants;

//     state = UserModel(
//       uid: uid,
//       status: status,
//       givenName: givenName,
//       surName: surName,
//       cnic: cnic,
//       phoneNumber: phoneNumber,
//       adults: adults,
//       childs: childs,
//       infants: infants,
//     );
//     print("User Info Saved: ${state}");
//   }

//   // Set the verification ID
//   void setVerificationId(String verificationId) {
//     this.verificationId = verificationId;
//     print("Verification ID Saved: $verificationId");
//   }

//   // Retrieve the verification ID
//   String? getVerificationId() {
//     return verificationId;
//   }
// }
