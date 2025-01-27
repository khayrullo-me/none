part of 'auth_bloc.dart';

class AuthState {
  bool? loading;
  bool? success;
  bool? verification;
  String? error;

  AuthState({this.loading, this.success, this.error,this.verification});

  AuthState copyWith({bool? loading, bool? success, String? error,bool?verification}) {
    return AuthState(
      loading: loading ?? this.loading,
      success: success ?? this.success,
      verification: verification ?? this.verification,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [];
}
