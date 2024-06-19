import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_planner/authentification/data/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_planner/user/domain/user_repo.dart';

class UserService extends UserRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserModel> getUser(String? uid) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    return UserModel(
      username: doc['username'],
      email: doc['email'],
      name: doc['name'],
      bio: doc['bio'],
      //avatar: doc['avatar'],
    );
  }

  @override
  Future<void> updateUser(
      {required UserModel user, required String uid}) async {
    await _firestore.collection('users').doc(uid).update(user.toMap());
  }
}

final userProvider = Provider<UserService>((ref) {
  return UserService();
});
