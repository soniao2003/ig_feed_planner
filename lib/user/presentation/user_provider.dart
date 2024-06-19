import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_planner/authentification/data/user_model.dart';
import 'package:instagram_planner/user/data/UserService.dart';

class UserStateProvider extends StateNotifier<UserModel> {
  late final UserService _userService;

  UserStateProvider(StateNotifierProviderRef ref, uid)
      : super(UserModel(
          username: 'initial_username',
          email: 'initial@email.com',
          name: 'initial_name',
          bio: 'initial_bio',
          //avatar: 'initial_avatar',
        )) {
    _userService = ref.read(userProvider);
    getUser(uid);
  }

  Future<void> getUser(String uid) async {
    state = await _userService.getUser(uid);
    print('user notfier read');
  }

  Future<void> updateUser(UserModel user, String uid) async {
    try {
      await _userService.updateUser(user: user, uid: uid);

      state = user;
    } catch (e) {
      print('Error updating user: $e');
      throw e;
    }
  }
}
