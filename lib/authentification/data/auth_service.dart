import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_planner/authentification/domain/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

class AuthService extends Auth_repo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<String?> registration({
    required String username,
    required String email,
    required String password,
    //required String avatar,
    required String name,
    required String bio,
  }) async {
    try {
      UserCredential userInfo = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await _firestore.collection('users').doc(userInfo.user!.uid).set({
        'email': email,
        'username': username,
        'name': name,
        'bio': bio,
        //'avatar': avatar,
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<String?> login(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // Future<Map<String, dynamic>?> getUserData() async {
  //   try {
  //     // Replace 'users' and 'userId' with your actual collection name and document ID
  //     var collection = FirebaseFirestore.instance.collection('users');
  //     var querySnapshot = await collection.get();
  //     for (var queryDocumentSnapshot in querySnapshot.docs) {
  //       Map<String, dynamic> data = queryDocumentSnapshot.data();
  //       String username = data['username'];
  //     }
  //     // DocumentSnapshot snapshot =
  //     //     await _firestore.collection('users').doc('userId').get();
  //     // return snapshot.data() as Map<String, dynamic>?;
  //   } catch (e) {
  //     print("Error fetching user data: $e");
  //     return null;
  //   }
  // }

  // Future<void> getUser(String uid) async {
  //   try {
  //     DocumentReference userDoc =
  //         FirebaseFirestore.instance.collection('users').doc(uid);
  //     final dataSnapshot = await userDoc.get();

  //     if (dataSnapshot.exists) {
  //       final data = dataSnapshot.data() as Map<String, dynamic>?;
  //       if (data != null) {
  //         print('Username: ${data["username"]}');
  //         print('Email: ${data["email"]}');
  //       } else {
  //         print('No data available');
  //       }
  //     } else {
  //       print('Document does not exist');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  @override
  Stream<List<UserModel>> getUserList() {
    return FirebaseFirestore.instance.collection('users').snapshots().map(
        (snapShot) => snapShot.docs
            .map((document) => UserModel.fromJson(document.data()))
            .toList());
  }

  @override
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  @override
  Future<DocumentSnapshot> getUser(String? uid) async {
    return _firestore.collection('users').doc(uid).get();
  }
}
