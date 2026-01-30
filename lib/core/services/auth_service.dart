import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Check if user exists in Firestore
  Future<bool> checkUserExists(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.exists;
  }

  // Create User Profile
  Future<void> createUserProfile({
    required String uid,
    required String name,
    required String role, // 'PARENT' or 'DRIVER'
    String? email,
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'uid': uid,
      'fullName': name,
      'email': email,
      'role': role,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
  
  // Note: Phone Auth usually requires a complex UI flow with OTP.
  // For this starter code, I will simulate a "Sign In" so you can test the UI.
}