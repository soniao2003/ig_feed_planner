import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_planner/authentification/data/user_model.dart';

abstract class Auth_repo {
  Future<String?> registration({
    required String username,
    required String email,
    required String password,
    required String name,
    required String bio,
    //required String avatar,
  });
  Future<String?> login({required String email, required String password});
  Stream<List<UserModel>> getUserList();
  Future<void> signOut();
  User? getCurrentUser();
  Future<DocumentSnapshot> getUser(String? uid);
}
