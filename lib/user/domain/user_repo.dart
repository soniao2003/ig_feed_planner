import 'package:instagram_planner/authentification/data/user_model.dart';

abstract class UserRepo {
  Future<UserModel> getUser(String? uid);
  Future<void> updateUser({required UserModel user, required String uid});
}
