import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sis/core/utils/constants.dart';

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);
final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);
final cloudinaryPublicProvider = Provider(
  (ref) => CloudinaryPublic(
    CloudinaryConstants.cloudName,
    CloudinaryConstants.uploadPreset,
  ),
);
