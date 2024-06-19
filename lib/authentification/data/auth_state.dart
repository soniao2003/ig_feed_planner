//model authstate z ktorego korzysta AuthNotifier
class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? errorMessage;

  AuthState({
    required this.isAuthenticated,
    required this.isLoading,
    this.errorMessage,
  });

  factory AuthState.initial() {
    return AuthState(
        isAuthenticated: false, isLoading: false, errorMessage: null);
  }

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
