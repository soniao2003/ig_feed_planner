import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_planner/authentification/data/auth_state.dart';
import 'package:instagram_planner/authentification/domain/auth_repo.dart';
import '../data/user_model.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final Auth_repo _authService;

//wstrzykujemy authService
//StateNotifier wymaga stanu inicjalizacyjnego (AuthState.initial())
  AuthNotifier(this._authService) : super(AuthState.initial());

  Future<void> register(String username, String email, String password,
      String name, String bio) async {
    state = state.copyWith(isLoading: true);
    final result = await _authService.registration(
        username: username,
        email: email,
        password: password,
        name: name,
        bio: bio);
    if (result == 'Success') {
      state = state.copyWith(isAuthenticated: true, isLoading: false);
    } else {
      state = state.copyWith(errorMessage: result, isLoading: false);
    }
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true);
    final result = await _authService.login(email: email, password: password);
    if (result == 'Success') {
      state = state.copyWith(isAuthenticated: true, isLoading: false);
    } else {
      state = state.copyWith(errorMessage: result, isLoading: false);
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    state = state.copyWith(isAuthenticated: false);
  }

  Stream<List<UserModel>> getUserList() {
    return _authService.getUserList();
  }

  // UserModel? getCurrentUser() {
  //   return _authService.getCurrentUser();
  // }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

// final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
//   return AuthNotifier(AuthService());
// });
