import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_planner/authentification/data/auth_service.dart';
import 'package:instagram_planner/authentification/data/user_model.dart';
import 'package:instagram_planner/authentification/data/auth_state.dart';
import 'package:instagram_planner/authentification/presentation/auth_provider.dart';
import 'package:instagram_planner/inspiration/data/inspiration_model.dart';
import 'package:instagram_planner/inspiration/presentation/inspiration_provider.dart';
import 'package:instagram_planner/inspiration/data/inspirationservice.dart';
import 'package:instagram_planner/profile/data/post_model.dart';
import 'package:instagram_planner/profile/presentation/post_provider.dart';
import 'package:instagram_planner/user/presentation/user_provider.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(AuthService());
});

//uzywamy family bo dla kazdego uid tworzymy nową instacje providera
final postNotifierProvider =
    StateNotifierProvider.family<PostNotifier, List<PostModel>, String>(
        (ref, uid) {
  return PostNotifier(ref, uid);
});

final userNotifierProvider =
    StateNotifierProvider.family<UserStateProvider, UserModel, String>(
        (ref, uid) {
  return UserStateProvider(ref, uid);
});
//family bo mamy rozne kategorie
final inspoNotifierProvider = StateNotifierProvider.family<InspirationsNotifier,
    List<InspirationModel>, String>((ref, category) {
  return InspirationsNotifier(ref, category);
});
